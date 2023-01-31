from tkinter import *
from functools import partial
import main
import mysql.connector as mysql
from cgitb import text
from tkinter import messagebox

def validateLogin(username, password):
    if(username.get() == "abc" and password.get() == "123"):
        exec(open('main.py').read())
    else:
        master = Tk()
        master.withdraw()
        messagebox.showerror(title='Error', message='Invalid Username or Password')

    #main.main()


#window
tkWindow = Tk()
tkWindow.geometry('400x150')
tkWindow.title('Wholesale agriculture login')

#username label and text entry box
usernameLabel = Label(tkWindow, text="User Name").place(x=50,y=30)
username = StringVar()
usernameEntry = Entry(tkWindow, textvariable=username).place(x=150,y=30)

#password label and password entry box
passwordLabel = Label(tkWindow,text="Password").place(x=50,y=60)
password = StringVar()
passwordEntry = Entry(tkWindow, textvariable=password, show='*').place(x=150,y=60)

validateLogin = partial(validateLogin, username, password)

#login button
loginButton = Button(tkWindow, height= 2, width= 25, text="Login", command=lambda:[tkWindow.destroy(), validateLogin()]).place(x=100,y=100)


tkWindow.mainloop()