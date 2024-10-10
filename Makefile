setup-gh-secret:
	gh secret set GHPAGES_GITHUB_TOKEN -b "xxx" -R siakhooi/rpms

setup-createrepo:
	yum install -y createrepo

clean:
	rm -rvf docs/repodata

build: clean
	bin/build-rpm-repo.sh
	ls -lR docs

gpg-key:
	bin/gpg-generate-key.sh

gpg-sign:
	export GNUPGHOME="$(mktemp -d)"
	cat keys/siakhooi-rpms.gpg.private.asc | gpg --import
	gpg --list-keys

	export GPG_KEY_NAME=siakhooi-rpms

	find . -name '*.rpm' -exec rpmsign -D "_gpg_name $GPG_KEY_NAME" --addsign {} \;
	rpm -Kv ./siakhooi-devutils-date-formats-1.0.2-1.fc40.noarch.rpm