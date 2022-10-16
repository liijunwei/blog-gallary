.PHONY: deploy view

commit:
	@git add . && git commit -m "Commit manually" --quiet && git push --force

deploy:
	@hexo deploy --generate --silent
	@ssh webuser@xiaoli "cd /srv/www/blog-gallary && git fetch && git checkout main && git reset --hard HEAD@{u}"

view:
	@open ${BLOG_DOMAIN}
