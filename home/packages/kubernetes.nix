{pkgs, ...}: {
  users.users.karixos.packages = with pkgs; [
    # Kubernetes core UX & CLI
    kubectl
    kubernetes-helm
    helmfile
    helm-docs
    chart-testing
    kustomize
    k9s
    kubectx
    kubecolor
    kubecm
    kubelogin
    kubelogin-oidc
    stern

    # Validation, linting, policy, and deprecation checks
    kubernetes-validate
    kubeconform
    kube-score
    kube-linter
    kubeaudit
    kubent
    pluto
    popeye
    datree
    conftest

    # Kubectl plugins and focused helpers
    kubectl-cnpg
    kubectl-doctor
    kubectl-images
    kubectl-klock
    kubectl-neat
    kubectl-tree
    kubectl-view-secret
    kubeseal

    # Local clusters, lifecycle, backup, and platform operations
    kind
    minikube
    k3d
    k3s
    kwok
    vcluster
    clusterctl
    talosctl
    velero
    kompose

    # GitOps, delivery, service mesh, and cloud-native app workflows
    argocd
    fluxcd
    skaffold
    tilt
    devspace
    ctlptl
    telepresence2
    mirrord
    cilium-cli
    cmctl
    crossplane-cli
    istioctl
    linkerd
    operator-sdk

    # Security and supply-chain tooling for clusters
    kubescape
    kyverno
    kyverno-chainsaw
    kube-hunter

    # Carvel and YAML diff/apply workflows
    kapp
    ytt
    kbld
    imgpkg
    vendir
    dyff
  ];
}
