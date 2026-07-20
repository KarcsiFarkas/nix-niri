{pkgs, ...}: {
  users.users.karixos.packages = with pkgs; [
    # Infrastructure as Code (IaC)
    terraform
    opentofu
    tflint
    tfsec
    terrascan
    checkov
    infracost

    # Ansible
    ansible
    ansible-lint

    # Containers & OCI Workflow
    docker-client
    docker-compose
    lazydocker
    podman
    podman-compose
    buildah
    skopeo
    dive
    crane
    oras
    cosign
    trivy
    syft
    grype

    # Cloud CLIs
    awscli2
    azure-cli
    google-cloud-sdk

    # Observability, HTTP & Debugging
    httpie
    grpcurl
    websocat
    vegeta
    hey
    k6
    graphviz
    prometheus.cli
    mimir
  ];
}
