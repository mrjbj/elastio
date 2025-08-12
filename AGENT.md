# Overview

This project relates to an instance of the hi.events open source event management system, which has been installed into an elestio cloud instance. The project is designed to manage events, including the creation of events, managing event details, and handling user interactions. It was installed via elestio's CD/CI pipeline, rather than as standalone vm.
The project is built using the Laravel framework and utilizes a MySQL database for data storage. The system is designed to be scalable and maintainable, with a focus on user experience and ease of use.

# Email Notifications

Email notifications are sent to users for various events, such as event creation and updates. The system also includes a user interface for managing events and viewing event details. The environment variables have been updated to send email via SMTP, and the necessary credentials have been provided in the .env file to connect it to Amazon SES for email delivery.

# Hardware and Operating System

my local system is macOS and i can login as root to the servier via ssh.
the elestio insance is running on a Ubuntu server, and the project is accessible via ssh and via web interface. The system is designed to be secure, with proper authentication and authorization mechanisms in place to protect user data and event information.

# tooling

lazyjournal (<https://github.com/Lifailon/lazyjournal?tab=readme-ov-file>) is installed to help with the logs and monitoriing.

# hi.events

documentation on hi.events can be found at <https://docs.hi.events/>. This documentation provides detailed information on how to use the system, including how to create and manage events, handle user interactions, and customize the system to meet specific needs.

# docker-compse

here is the docker-compose file used to run the project:

```yaml
iservices:
  all-in-one:
    image: daveearley/hi.events-all-in-one:${SOFTWARE_VERSION_TAG}
    restart: always
    ports:
      - "172.17.0.1:13336:80"
    environment:
      - VITE_FRONTEND_URL=https://${DOMAIN}
      - APP_FRONTEND_URL=https://${DOMAIN}
      - VITE_API_URL_CLIENT=https://${DOMAIN}/api
      - VITE_API_URL_SERVER=http://localhost:80/api
      - VITE_STRIPE_PUBLISHABLE_KEY=${VITE_STRIPE_PUBLISHABLE_KEY}
      - LOG_CHANNEL=stderr
      - QUEUE_CONNECTION=sync
      - MAIL_MAILER=array
      - APP_KEY=${APP_KEY}
      - JWT_SECRET=${JWT_SECRET}
      - FILESYSTEM_PUBLIC_DISK=public
      - FILESYSTEM_PRIVATE_DISK=local
      - APP_CDN_URL=https://${DOMAIN}/storage
      - DATABASE_URL=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}
      - MAIL_MAILER=${MAIL_MAILER}
      - MAIL_HOST=${MAIL_HOST}
      - MAIL_PORT=${MAIL_PORT}
      - MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS}
      - MAIL_FROM_NAME=${MAIL_FROM_NAME}
      - MAIL_USERNAME=${MAIL_USERNAME}
      - MAIL_PASSWORD=${MAIL_PASSWORD}
      - MAIL_ENCRYPTION=${MAIL_ENCRYPTION}

    depends_on:
      - postgres

  postgres:
    image: elestio/postgres:16
    restart: always
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    ports:
      - 172.17.0.1:43360:5432
    volumes:
      - ./pgdata:/var/lib/postgresql/data

  pgadmin:
    image: elestio/pgadmin:latest
    restart: always
    environment:
      PGADMIN_DEFAULT_EMAIL: ${ADMIN_EMAIL}
      PGADMIN_DEFAULT_PASSWORD: ${ADMIN_PASSWORD}
      PGADMIN_LISTEN_PORT: 8080
    ports:
      - "172.17.0.1:31829:8080"
    volumes:
      - ./servers.json:/pgadmin4/servers.json

