from flask import Flask, render_template, request, redirect, url_for
from sqlalchemy import create_engine, MetaData, text
from sqlalchemy.orm import scoped_session, sessionmaker


app = Flask(__name__)
DATABASE_URL = "postgresql://postgres:yourpassword@localhost:5432/health_reporting_db"

engine = create_engine(DATABASE_URL)
metadata = MetaData(bind=engine)
Session = scoped_session(sessionmaker(bind=engine))
session = Session()

metadata.reflect()
Users = metadata.tables['users']

@app.route('/')
def index():
    return render_template('index.html')
@app.route('/users')
def view_users():
    query = text("SELECT * FROM Users;")
    result = session.execute(query).fetchall()
    return render_template('view.html', users=result)
@app.route('/add', methods=['GET', 'POST'])
def add_user():
    if request.method == 'POST':
        email = request.form['email']
        name = request.form['name']
        surname = request.form['surname']
        salary = request.form['salary']
        cname = request.form['cname']
        query = text("""
            INSERT INTO Users (email, name, surname, salary, cname)
            VALUES (:email, :name, :surname, :salary, :cname)
        """)
        session.execute(query, {
            'email': email, 'name': name, 'surname': surname, 'salary': salary, 'cname': cname
        })
        session.commit()
        return redirect(url_for('view_users'))
    return render_template('add.html')

@app.route('/edit/<email>', methods=['GET', 'POST'])
def edit_user(email):
    if request.method == 'POST':
        name = request.form['name']
        surname = request.form['surname']
        salary = request.form['salary']
        cname = request.form['cname']
        query = text("""
            UPDATE Users
            SET name = :name, surname = :surname, salary = :salary, cname = :cname
            WHERE email = :email
        """)
        session.execute(query, {'name': name, 'surname': surname, 'salary': salary, 'cname': cname, 'email': email})
        session.commit()
        return redirect(url_for('view_users'))
    query = text("SELECT * FROM Users WHERE email = :email")
    user = session.execute(query, {'email': email}).fetchone()
    return render_template('edit.html', user=user)
@app.route('/delete/<email>', methods=['GET', 'POST'])
def delete_user(email):
    if request.method == 'POST':
        query = text("DELETE FROM Users WHERE email = :email")
        session.execute(query, {'email': email})
        session.commit()
        return redirect(url_for('view_users'))
    return render_template('delete.html', email=email)


if __name__ == '__main__':
    app.run(debug=True)
