# Use the standard Nginx image from Docker Hub
FROM nginx

RUN apt-get update && apt-get install iputils-ping -y && apt-get purge -y --auto-remove

# The Dockerfile's author
LABEL Usama Ashraf

# Copy custom configuration file from the current directory
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html


EXPOSE 80

# Start Nginx when the container has provisioned.
CMD ["nginx", "-g", "daemon off;"]
