# iit-cms

CMS for Inkubator IT 2021, powered by Strapi.

## Run Locally

You only need `docker` and `docker-compose` as the bare minimum to test the CMS locally.

Clone the project, and go to the project directory

```bash
  git clone https://github.com/IIT-Dev/iit-cms
  cd iit-cms
```

Pull required images/dependencies via docker-compose

```bash
  docker-compose pull
```

Start the CMS, after setting the environment variables with the example provided in the `env` folder.

```bash
  docker-compose up -d
```

## Deployment

You can always do the deployment manually, by SSH-ing into the server and do the procedures written on the "_Run Locally_" Section.
This repository will include automation for the deployment (WIP).
Terraform IaC file will be included for easier possible migrations in the future (WIP).

## Tech

- Using Docker to compose Strapi and PostgreSQL
- (WIP) Using Terraform for IaC for easier setup

## Roadmap

- [x] ~Docker Compose file for running the CMS~
- [ ] CI/CD pipeline for possible changes in the compose file (WIP, waiting for server)
- [ ] Terraform IaC for possible migration in the future (WIP, waiting for server to test code)

## Documentation

Documentations relating to the tech used:

- [Strapi Documentation](https://strapi.io/documentation/developer-docs/latest/getting-started/introduction.html)
- [Docker Documentation](https://docs.docker.com/)
- [Terraform](https://www.terraform.io/)

## Authors

- [@mkamadeus](https://www.github.com/mkamadeus)
