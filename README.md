First Create web servers and the db servers.

To Create Web Cluster
Go to prod/web and use the below commands to build, review and execute.

terraform init <br/>
terraform get <br/>
terraform plan <br/>
terraform apply <br/>

To Create DB
Go to prod/db and use the above commands to build, review and execute. Provide dbpassword

After creating instaces see the output of web module for URL and append /mediawiki after domain.
Then to setup mediawiki use db module's output for dbname and host. username is root and password which is provided while creating db.
After setup Mediawiki create image of running instace for autoscaling. Go to image directory run above terraform commands to create image and see output for image id and change it vars.tf in web dir, So next time whenever we change the number of instances in main.tf terraform will use new image for instances which has media setup already.
