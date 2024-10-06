setup-gh-secret:
	gh secret set GHPAGES_GITHUB_TOKEN -b "xxx" -R siakhooi/rpms

setup-createrepo:
	yum install -y createrepo

clean:
	rm -rvf docs/repodata

build: clean
	bin/build-rpm-repo.sh
	ls -lR docs
