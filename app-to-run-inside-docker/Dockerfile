# stage 1

# FROM node:alpine AS my-app-build

# WORKDIR /usr/src/app
# COPY . /usr/src/app
# RUN npm install && npm run build

# stage 2
# FROM nginx:alpine
# COPY --from=my-app-build /usr/src/app/dist/app-to-run-inside-docker /usr/share/nginx/html
# EXPOSE 80



# stage 1
# FROM node:alpine AS my-app-build
# RUN apk add --no-cache git && apk add --no-cache openssh
# RUN git clone -b master https://github.com/MoonyHsiao/PathNameTest.git /usr/src/app
# WORKDIR /usr/src/app
# RUN npm install && npm run build


# stage 2
# FROM nginx:alpine
# COPY --from=my-app-build /usr/src/app/dist/PathNameTest /usr/share/nginx/html
# EXPOSE 80


# with ssh
# stage 1
FROM node:alpine AS my-app-build
RUN apk add --no-cache git && apk add --no-cache openssh
RUN git clone -b master https://github.com/MoonyHsiao/PathNameTest.git /usr/src/app
WORKDIR /usr/src/app
RUN npm install && npm run build

# stage 2
FROM nginx:alpine
# COPY --from=my-app-build /usr/src/app/dist/PathNameTest /usr/share/nginx/html
RUN apk add --no-cache git && apk add --no-cache openssh
RUN echo "root ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER root

# ADD deploy /.docker
ADD . /.docker
RUN chown -R root:root /.docker
RUN chmod -R 755 /.docker

# Install dependencies
RUN apk add --update \
    openssh \
    mc \
    git && \
    sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && \
    ssh-keygen -A
COPY --from=my-app-build /usr/src/app/dist/PathNameTest /usr/share/nginx/html

EXPOSE 80 22
CMD sh /.docker/deploy/entrypoint.sh && sh /.docker/deploy/daemon.sh
# CMD ["sh","/.docker/deploy/entrypoint.sh","sh","sh /.docker/deploy/daemon.sh","nginx", "-g", "daemon off;"]

# CMD sh /.docker/deploy/entrypoint.sh  && nginx -g daemon off;&& sh /.docker/deploy/daemon.sh
# CMD sh /.docker/deploy/entrypoint.sh; sleep infinity;