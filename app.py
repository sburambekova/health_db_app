# from flask import Flask, render_template, request, redirect, url_for
# from sqlalchemy import create_engine, MetaData, text
# from sqlalchemy.orm import scoped_session, sessionmaker
# import os



# app = Flask(__name__)
# # app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://health_reporting_db_user:dgh22mH4EbUWMEjwxWbCN7woDHywIuIo@dpg-cstnvd5umphs73frp4e0-a.oregon-postgres.render.com/health_reporting_db?sslmode=require'


# app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
# app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Disable Flask-SQLAlchemy's modification tracking
# app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')  # Make sure you have a secret key set


# # app.config["SQLALCHEMY_DATABASE_URL"] = os.environ.get("DATABASE_URL")
# # DATABASE_URL = os.getenv(
# #     "DATABASE_URL",
# #     "postgresql://health_reporting_db_user:dgh22mH4EbUWMEjwxWbCN7woDHywIuIo@dpg-cstnvd5umphs73frp4e0-a.oregon-postgres.render.com/health_reporting_db?sslmode=require"
# # )

# #postgresql://health_reporting_db_user:dgh22mH4EbUWMEjwxWbCN7woDHywIuIo@dpg-cstnvd5umphs73frp4e0-a.oregon-postgres.render.com/health_reporting_db

# DATABASE_URL = os.getenv('DATABASE_URL')  # Fetch it from the environment variable

# engine = create_engine(
#     DATABASE_URL,
#     connect_args={"sslmode": "require"}
# )


# metadata = MetaData()
# metadata.reflect(bind=engine)

# Session = scoped_session(sessionmaker(bind=engine))
# session = Session()


# Users = metadata.tables['users']

# @app.route('/')
# def index():
#     return render_template('index.html')
# @app.route('/users')
# def view_users():
#     query = text("SELECT * FROM Users;")
#     result = session.execute(query).fetchall()
#     return render_template('view.html', users=result)
# @app.route('/add', methods=['GET', 'POST'])
# def add_user():
#     if request.method == 'POST':
#         email = request.form['email']
#         name = request.form['name']
#         surname = request.form['surname']
#         salary = request.form['salary']
#         cname = request.form['cname']
#         query = text("""
#             INSERT INTO Users (email, name, surname, salary, cname)
#             VALUES (:email, :name, :surname, :salary, :cname)
#         """)
#         session.execute(query, {
#             'email': email, 'name': name, 'surname': surname, 'salary': salary, 'cname': cname
#         })
#         session.commit()
#         return redirect(url_for('view_users'))
#     return render_template('add.html')

# @app.route('/edit/<email>', methods=['GET', 'POST'])
# def edit_user(email):
#     if request.method == 'POST':
#         name = request.form['name']
#         surname = request.form['surname']
#         salary = request.form['salary']
#         cname = request.form['cname']
#         query = text("""
#             UPDATE Users
#             SET name = :name, surname = :surname, salary = :salary, cname = :cname
#             WHERE email = :email
#         """)
#         session.execute(query, {'name': name, 'surname': surname, 'salary': salary, 'cname': cname, 'email': email})
#         session.commit()
#         return redirect(url_for('view_users'))
#     query = text("SELECT * FROM Users WHERE email = :email")
#     user = session.execute(query, {'email': email}).fetchone()
#     return render_template('edit.html', user=user)
# @app.route('/delete/<email>', methods=['GET', 'POST'])
# def delete_user(email):
#     if request.method == 'POST':
#         query = text("DELETE FROM Users WHERE email = :email")
#         session.execute(query, {'email': email})
#         session.commit()
#         return redirect(url_for('view_users'))
#     return render_template('delete.html', email=email)


# if __name__ == "__main__":
#     app.run()
from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
import os

# Initialize Flask app
app = Flask(__name__)

# Set up the database URI
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Disable Flask-SQLAlchemy's modification tracking
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

# Initialize SQLAlchemy ORM
db = SQLAlchemy(app)

# Define your Users model using Flask-SQLAlchemy
class User(db.Model):
    __tablename__ = 'users'

    email = db.Column(db.String, primary_key=True)
    name = db.Column(db.String)
    surname = db.Column(db.String)
    salary = db.Column(db.Float)
    cname = db.Column(db.String)

    def __init__(self, email, name, surname, salary, cname):
        self.email = email
        self.name = name
        self.surname = surname
        self.salary = salary
        self.cname = cname

# Routes
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/users')
def view_users():
    users = User.query.all()
    return render_template('view.html', users=users)

@app.route('/add', methods=['GET', 'POST'])
def add_user():
    if request.method == 'POST':
        email = request.form['email']
        name = request.form['name']
        surname = request.form['surname']
        salary = request.form['salary']
        cname = request.form['cname']

        new_user = User(email=email, name=name, surname=surname, salary=salary, cname=cname)
        db.session.add(new_user)
        db.session.commit()

        return redirect(url_for('view_users'))
    return render_template('add.html')

@app.route('/edit/<email>', methods=['GET', 'POST'])
def edit_user(email):
    user = User.query.get_or_404(email)

    if request.method == 'POST':
        user.name = request.form['name']
        user.surname = request.form['surname']
        user.salary = request.form['salary']
        user.cname = request.form['cname']
        
        db.session.commit()

        return redirect(url_for('view_users'))

    return render_template('edit.html', user=user)

@app.route('/delete/<email>', methods=['GET', 'POST'])
def delete_user(email):
    user = User.query.get_or_404(email)

    if request.method == 'POST':
        db.session.delete(user)
        db.session.commit()
        return redirect(url_for('view_users'))

    return render_template('delete.html', user=user)


if __name__ == "__main__":
    app.run()
