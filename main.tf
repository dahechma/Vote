terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Création d'un réseau Docker
resource "docker_network" "voting_network" {
  name = "voting-network"
}

# Service Vote
resource "docker_image" "vote" {
  name = "dockersamples/examplevotingapp_vote:latest"
}

resource "docker_container" "vote" {
  name  = "vote"
  image = docker_image.vote.image_id
  ports {
    internal = 80
    external = 5000
  }
  networks_advanced {
    name = docker_network.voting_network.name
  }
}

# Service Redis
resource "docker_image" "redis" {
  name = "redis:alpine"
}

resource "docker_container" "redis" {
  name  = "redis"
  image = docker_image.redis.image_id
  networks_advanced {
    name = docker_network.voting_network.name
  }
}

# Worker
resource "docker_image" "worker" {
  name = "dockersamples/examplevotingapp_worker:latest"
}

resource "docker_container" "worker" {
  name    = "worker"
  image   = docker_image.worker.image_id
  networks_advanced {
    name = docker_network.voting_network.name
  }
  depends_on = [
    docker_container.redis,
    docker_container.db
  ]
}

# Base de données Postgres
resource "docker_image" "db" {
  name = "postgres:15-alpine"
}

resource "docker_container" "db" {
  name  = "db"
  image = docker_image.db.image_id
  env = [
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=postgres"
  ]
  networks_advanced {
    name = docker_network.voting_network.name
  }
}

# Service Result
resource "docker_image" "result" {
  name = "dockersamples/examplevotingapp_result:latest"
}

resource "docker_container" "result" {
  name  = "result"
  image = docker_image.result.image_id
  ports {
    internal = 80
    external = 5001
  }
  networks_advanced {
    name = docker_network.voting_network.name
  }
  depends_on = [docker_container.db]
}