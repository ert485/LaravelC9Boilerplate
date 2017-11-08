# Laravel C9 Boilerplate
This is a template for development of any Laravel Project,<br>
with instructions how to start development in Cloud 9
<br><br>
### Step 1: Register/Login at <a href="c9.io">c9.io</a>
    
### Step 2: <a href="https://docs.c9.io/docs/create-a-workspace">Create a workspace</a>
- on the "Clone from Git" option, enter the following: <br>
    `https://github.com/ert485/LaravelC9Boilerplate`

### Step 3: Setup Laravel
- run the folling in the workspace terminal:
    ```bash
    cd ~/workspace          
    chmod +x buildc9.sh     # set executable permission
    ./buildc9.sh            # run setup script
    ```
You should now have an empty but working website!<br>
The script will finish by printing the location of the site.<br>
The cloud 9 database will be accessible to laravel.<br>


# The following steps are optional features

### Option 1: Allow logins
- run the folling in the workspace terminal:
    ```bash
    cd ~/workspace
    php artisan make:auth   # generate login database and layout
    ```
### Option 2: Allow Login with Socialite (requires Option 1)
    More details to come
    
    
    
