.PHONY: deploy view

commit:
	@git add . && git commit -m "Commit manually" --quiet && git push --force

view:
	@open ${BLOG_DOMAIN}

sync:
	@hexo generate --silent
	@rsync -azP public/ webuser@xiaoli:/srv/www/blog-gallary
	@echo done
