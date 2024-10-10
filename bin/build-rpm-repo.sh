#!/bin/bash

set -e

cd docs && (

    GNUPGHOME="$(mktemp -d)"
    export GNUPGHOME
    echo "$GPG_PRIVATE_KEY" | gpg --import
    gpg --list-keys

    find . -name '*.rpm' -exec rpmsign -D "_gpg_name $GPG_KEY_NAME" --addsign {} \;

    createrepo .
)
