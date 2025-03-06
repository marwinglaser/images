target "default" {
  name = "${base.image}-${replace(base.version, ".", "-")}"

  matrix = {
    base = [
      { image = "ubuntu", version = "18.04" },
      { image = "ubuntu", version = "20.04" },
      { image = "ubuntu", version = "22.04" },
      { image = "ubuntu", version = "24.04" },
    ]
  }

  tags = ["ghcr.io/marwinglaser/ci:${base.image}-${base.version}"]

  dockerfile-inline = <<Dockerfile
    FROM ${base.image}:${base.version}
    ENV DEBIAN_FRONTEND=noninteractive
    RUN \
      apt-get update -y && \
      apt-get install -y sudo git && \
      useradd --uid 1001 ci && \
      echo 'ci ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    USER ci
  Dockerfile
}
