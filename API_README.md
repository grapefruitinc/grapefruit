API Specs
---------
All requests should be sent to "/api/v1/****", **** replacing the action you want to execute.

When a response from the server contains an email, and authentication_token, SAVE IT. These are required
to send requests that require authentication to the server.

All possible requests will be posted below with their requirements, and examples for them will be found in the section below this:

###User Actions

####sign_up
User create action: requires a POST in the format: { user: { email: email@example.com, password: password8, name: "Damian Mastylo" } }. If successful, you will get a response in a JSON format containing the User id, email, phone number and authentication_token.

####edit_account
User update action: requires a PUT in the format: { authentication_data: { email: email@example.com, authentication_token: 555 }, user: { email: email@example.com, password: password8, name: Example Name } }. Everything in the user block is optional. Only put in the parameters you want to change. If successful, you will get a response in a JSON format containing the User id, email, name, and authentication_token.

####sign_in
Sessions create action: requires a POST in the format: { user: { email: email@example.com, password: password8 } }. If successful, you will get a response in a JSON format containing the User id, email, name, and authentication_token.

####sign_out
Sessions destroy action: requires a DELETE in the format: { authentication_data: { email: email@example.com, authentication_token: 555 } }. If successful, the authentication_token will be deleted and not work anymore, and you will simply receive a "success: true" JSON message. Sign in again to retrieve a new authentication authentication_token.

###Forgot Password Actions

####forgot_password
Forgot Password Request create action: requires a POST in the format: { user: { email: email@example.com } }. If successful, you will get a response in a JSON format containing the User email. The reset_password_token will be sent to the user via email to the email address linked to their account.

####change_password
Forgot Password Request update action: requires a PUT in the format: { user: { password: password8, password_confirmation: password8, reset_password_token: ff098f098FLKJDF... } }. If successful, you will get a response in a JSON format containing the User id, email, name, and authentication_token.

###Course Actions

####courses
Courses index action: requires a GET in the format: { authentication_data: { email: email@example.com, authentication_token: 555 } }. You will get a response in a JSON format containing all courses.

####courses/show
Course show action: requires a GET in the format: { authentication_data: { email: email@example.com, authentication_token: 555 } }. Replace "show" with the id of the Course you want to view. You will get a response in a JSON format containing all the Course attributes including the announcements, instructor, and capsules.

###Capsule Actions

####courses/course_id/capsules
Capsules index action: requires a GET in the format: { authentication_data: { email: email@example.com, authentication_token: 555 } }. You will get a response in a JSON format containing all capsules of the course.

####courses/course_id/capsules/show
Capsule show action: requires a GET in the format: { authentication_data: { email: email@example.com, authentication_token: 555 } }. Replace "show" with the id of the Capsule you want to view. You will get a response in a JSON format containing all the capsule attributes including the lectures.

Example Curl commands for API Testing
--------------------------------------

Add a -v flag to also display full information about the header file and response.

###User Actions

User Create
````
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{ "user": { "email": "dmastylo@gmail.com", "password": "12345678", "name": "Damian Mastylo" } }' 'localhost:3000/api/v1/sign_up'
````

User Edit
````
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X PUT -d '{ "authentication_data": { "email": "dmastylo@gmail.com", "authentication_token": "Nszp-zU2KztmYP2mbsfs" }, "user": { "name": "Damian Mastylo" } }' 'localhost:3000/api/v1/edit_account'
````

User Sign_in
````
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{ "user": { "email": "dmastylo@gmail.com", "password": "123456789" } }' 'localhost:3000/api/v1/sign_in'
````

User Sign_out
````
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X DELETE -d '{ "authentication_data": { "email": "dmastylo@gmail.com", "authentication_token": "Nszp-zU2KztmYP2mbsfs" } }' 'localhost:3000/api/v1/sign_out'
````

###Forgot Password Actions

Forgot Password Request Create
````
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST -d '{ "user": { "email": "polishown3r@gmail.com" } }' 'localhost:3000/api/v1/forgot_password'
````

Forgot Password Request Edit
````
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X PUT -d '{ "user": { "password": "123456789", "password_confirmation": "123456789", "reset_password_token": "ff098f098FLKJDF..." } }' 'localhost:3000/api/v1/change_password'
````

###Course Actions

Course Index
````
curl -H 'Content-Type: application/json' -H "Accept: application/json" -X GET -d '{ "authentication_data": { "email": "polishown3r@gmail.com", "authentication_token": "Nszp-zU2KztmYP2mbsfs" } }' 'localhost:3000/api/v1/courses'
````

Course Show
````
curl -H 'Content-Type: application/json' -H "Accept: application/json" -X GET -d '{ "authentication_data": { "email": "polishown3r@gmail.com", "authentication_token": "Nszp-zU2KztmYP2mbsfs" } }' 'localhost:3000/api/v1/courses/15'
````

###Capsule Actions

Capsule Index
````
curl -H 'Content-Type: application/json' -H "Accept: application/json" -X GET -d '{ "authentication_data": { "email": "polishown3r@gmail.com", "authentication_token": "Nszp-zU2KztmYP2mbsfs" } }' 'localhost:3000/api/v1/courses/1/capsules'
````

Capsule Show
````
curl -H 'Content-Type: application/json' -H "Accept: application/json" -X GET -d '{ "authentication_data": { "email": "polishown3r@gmail.com", "authentication_token": "Nszp-zU2KztmYP2mbsfs" } }' 'localhost:3000/api/v1/courses/1/capsule/2'
````
