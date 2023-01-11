FROM us-central1-docker.pkg.dev/planton-shared-services-jx/afs-planton-pos-uc1-ext-docker/gitlab.com/plantoncode/planton/pcs/tool/cli:v0.0.35-v1
COPY entrypoint.sh /entrypoint.sh
 
ENTRYPOINT ["/entrypoint.sh"]
