site:
	newartisans rebuild

deploy: site
	@echo Copying files...
	rsync --checksum -av --delete _site/ jw2:/srv/newartisans/

	@echo Setting ownership...
	ssh jw2 chown -R nginx:nginx /srv/newartisans

	@echo Setting permissions...
	ssh jw2 chmod -R ugo+rX /srv/newartisans

	@echo Setting contexts...
	ssh jw2 chcon -R -u system_u -t httpd_sys_content_t /srv/newartisans

	@echo Restarting nginx...
	ssh jw2 service nginx restart
