from flask import Flask, render_template, request, redirect, session
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from datetime import datetime
from werkzeug.utils import secure_filename
import math
import json
import os

with open('config.json','r') as c: 
    params = json.load(c)["params"]

app = Flask(__name__)
app.secret_key=params['secret_key']
app.config['UPLOAD_FOLDER']= params['upload_location']

#--mail-setup--
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail_user'],
    MAIL_PASSWORD = params['gmail_password']
)
mail= Mail(app)


#--database-setup--
local_server= params['local_server']    
if local_server:    
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
app.config['SQLALCHEMY_TRACK_MODIFICATIONS']= False 
db= SQLAlchemy(app)
class Contacts(db.Model):  #----contacts-db
    sno= db.Column(db.Integer, primary_key=True)
    name= db.Column(db.String(20),  nullable=False)
    email= db.Column(db.String(50),  nullable=False)
    phone= db.Column(db.String(12),  nullable=False)
    message= db.Column(db.String(50),  nullable=False)
    date= db.Column(db.String(50),  nullable=False)
class Posts(db.Model):  #----posts-db
    sno= db.Column(db.Integer, primary_key=True)
    title= db.Column(db.String(100),  nullable=False)
    tagline= db.Column(db.String(500),  nullable=False)
    slug= db.Column(db.String(30),  nullable=False)
    content= db.Column(db.String(100),  nullable=False)    
    date= db.Column(db.String(50),  nullable=False)


#----HOME----
@app.route('/')
def home():
    posts= Posts.query.filter_by().all()
    last=math.ceil(len(posts)/int(params['number_of_post']))
    page= request.args.get('page')
    if not str(page).isnumeric():
        page=1
    page=int(page)
    posts = posts[(page-1)*int(params['number_of_post']):(page-1)*int(params['number_of_post'])+int(params['number_of_post'])]
    if page==1:
        prev='#'
        next= '/?page='+str(page+1)
    elif page==last:
        prev= '/?page='+str(page-1)
        next= '#'
    else:
        prev= '/?page='+str(page-1)
        next= '/?page='+str(page+1)
    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)

#----POST----
@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)

#----ABOUT----
@app.route('/about')
def about():
    return render_template('about.html', params=params)


#----CONTACT----
@app.route('/contact', methods=['GET','POST'])
def contact():
    # sno,name,email,phone,message,date
    if request.method=='POST':
        name= request.form.get('name')
        email= request.form.get('email')
        phone= request.form.get('phone')
        message= request.form.get('message')
        entry= Contacts(name=name, email=email, phone=phone, message=message, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message(name, sender=email, recipients= [params['gmail_user']], body= message) 
    return render_template('contact.html', params=params)


#----DASHBOARD----
@app.route('/dashboard', methods=['GET','POST'])
def dashboard():
    if 'loged_user' in session and session['loged_user']== params['admin_user']:
        posts= Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)
    if request.method=='POST':
        username= request.form.get('username')
        password= request.form.get('password')
        if username==params['admin_user'] and password==params['admin_password']:
            session['loged_user']=username
            posts= Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)
    else:
        return render_template('login.html', params=params)
    return render_template('login.html', params=params)

#----EDIT----
@app.route("/edit/<string:sno>", methods=['GET','POST'])
def edit(sno):
    if 'loged_user' in session and session['loged_user']== params['admin_user']:
        if request.method=='POST':
            title= request.form.get('title')
            tagline= request.form.get('tagline')
            slug= request.form.get('slug')
            content= request.form.get('content')
            if sno=='0':
                post= Posts(title=title,tagline=tagline,slug=slug,content=content,date=datetime.now())
                db.session.add(post)
                db.session.commit()
            else:
                post= Posts.query.filter_by(sno=sno).first()
                post.title=title
                post.tagline=tagline
                post.slug=slug
                post.content=content
                post.date= datetime.now()
                db.session.commit()
                return redirect('/edit/'+sno)
        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post, sno=sno)

#----UPlOADER----
@app.route("/uploader",methods=['GET','POST'])
def uploader():
    if 'loged_user' in session and session['loged_user']== params['admin_user']:
        if request.method=='POST':
            f= request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            return "Uploaded Successfully"


#----DELETE----
@app.route('/delete/<string:sno>', methods=['GET','POST'])
def delete(sno):
    if 'loged_user' in session and session['loged_user']== params['admin_user']:
        post= Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect('/dashboard')

#----LOGOUT----
@app.route('/logout')
def logout():
    session.pop('loged_user')
    return redirect('/dashboard')
    

app.run(debug=True, port=5050) #running app 