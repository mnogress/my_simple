DOCKER = docker

DOCKER_IMAGE = minimal-mistakes-jekyll
DOCKER_CONTAINER = minimal-mistakes-jekyll

.PHONY: docker-build jekyll-build jekyll-serve

docker-build:
	mkdir -p tmp
	cp Gemfile Dockerfile tmp/
	docker build tmp/ -t $(DOCKER_IMAGE)

jekyll-serve:
	docker run --rm -it --name $docker_jekell -v $$PWD/_config.yml:/work/_config.yml -v $$PWD/index.html:/work/index.html \
		-v $$PWD/_data/:/work/_data/ \
		-v $$PWD/_posts/:/work/_posts/ \
		-v $$PWD/_site/:/work/_site/ \
		-v $$PWD/images/:/work/images/ \
		-p 4000:4000 \
		-w /work \
		$(DOCKER_IMAGE) \
		bundle exec jekyll serve --config _config.yml -H 0.0.0.0 --future --incremental

jekyll-build:
	docker run --rm -it --name $(DOCKER_CONTAINER) \
		-v $$PWD/_config.yml:/work/_config.yml \
		-v $$PWD/index.html:/work/index.html \
		-v $$PWD/_data/:/work/_data/ \
		-v $$PWD/_posts/:/work/_posts/ \
		-v $$PWD/_site/:/work/_site/ \
		-v $$PWD/images/:/work/images/ \
		-w /work \
		-e JEKYLL_ENV=production \
		$(DOCKER_IMAGE) \
		bundle exec jekyll build
