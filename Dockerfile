FROM us-central1-docker.pkg.dev/ca-planton-gcp-sh-zg/afs-planton-oss-gcp-uc1-docker/github.com/plantoncloud/planton-clid:v0.0.61
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
