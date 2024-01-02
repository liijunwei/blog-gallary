.PHONY: sync commit view

sync:
	@hexo generate --silent
	@rsync -azP public/ me@xiaoli:/home/me/blog
	@echo done

commit:
	@git add . && git commit -m "Commit manually" --quiet && git push --force

view:
	@open ${BLOG_DOMAIN}
