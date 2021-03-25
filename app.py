from flask import Flask,render_template,request,session,redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.utils import secure_filename
import json
import os
from flask_mail import Mail
import math


with open('config.json','r') as c:
    params=json.load(c)["params"]

local_server=True
app = Flask(__name__)
app.secret_key='super-secret-key'
app.config['UPLOAD_FOLDER']=params['upload_location']
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
    

)
mail=Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI']= params['prod_uri']

db = SQLAlchemy(app)

class Contact(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120),  nullable=False)
    date = db.Column(db.String(12),  nullable=True)
    email = db.Column(db.String(20), nullable=False)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(30), nullable=False)
    slug = db.Column(db.String(30),  nullable=False)
    date = db.Column(db.String(12),  nullable=True)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    img_name = db.Column(db.String(12), nullable=False)


@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    print(last,"last")
    page = request.args.get('page')
    if(not str(page).isnumeric()):
        page = 1
    page= int(page)
    posts = posts[(page-1)*int(params['no_of_posts']): (page-1)*int(params['no_of_posts'])+ int(params['no_of_posts'])]
    #Pagination Logic
    #First
    if (page==1):
        prev = "#"
        next = "/?page="+ str(page+1)
    elif(page==last):
        prev = "/?page=" + str(page - 1)
        next = "#"
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)

@app.route('/about')
def about():
    return render_template('about.html')
    
@app.route('/edit/<string:sno>',methods=['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            req_titles =request.form.get('title')
            req_tagline=request.form.get('tagline')
            req_slug=request.form.get('slug')
            req_content=request.form.get('content')
            req_image=request.form.get('img_name')
            date= datetime.now()
            if sno=="0":
                posts= Posts(title=req_titles,slug=req_slug,content=req_content,img_name=req_image,tagline=req_tagline,date=date)
                db.session.add(posts)
                db.session.commit()
            else:
                posts=Posts.query.filter_by(sno=sno).first()
                posts.title=req_titles
                posts.slug=req_slug
                posts.content=req_content
                posts.img_name=req_image
                posts.tagline=req_tagline
                posts.date=date
                db.session.commit()
                return redirect('/edit/'+sno)
        posts= Posts.query.filter_by().first()
        return render_template('edit.html',posts=posts)


@app.route('/admin',methods=['GET','POST'])
def admin():

    #To check if the user is already logged in
    if 'user' in session and session['user'] == params['admin_user']:
        posts= Posts.query.all()
        return render_template('dashboard.html',posts=posts)
    if request.method == 'POST':
        username=request.form.get('uname')
        password=request.form.get('pass')
        if username == params['admin_user'] and password == params['admin_pass']:
            session['user'] = username
            posts= Posts.query.all()
            return render_template('dashboard.html',posts=posts)
    return render_template('login.html')

@app.route('/contact',methods=['GET', 'POST'])
def contact():
    if request.method == 'POST':
        name=request.form.get('name')
        email=request.form.get('email')
        phone_num=request.form.get('phone')
        message=request.form.get('message')
        entry=Contact(name=name,email=email,phone_num=phone_num,msg=message,date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        mail.send_message("New Message from Blog",
        sender=email,recipients=[params['gmail-user']],
        body=message + "\n" +phone_num)


    return render_template('contact.html')


@app.route('/uploader',methods=['GET','POST'])
def uploader():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "Uploaded Succesfully"


@app.route('/post/<string:post_slug>',methods=['GET'])
def post_route(post_slug):
    post= Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html',post=post)


@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/')


@app.route('/delete/<string:sno>',methods=['GET', 'POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        posts=Posts.query.filter_by(sno=sno).first()
        db.session.delete(posts)
        db.session.commit()
    return redirect('/admin')



if __name__ == '__main__':
    app.run(debug=True)
    