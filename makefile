deploy:
	flutter build web && \
	cd /Users/iamsahilsonawane/Projects/FlutterNest/automation_wrapper_builder/web_app &&  \
	find . -not -path '*/\.git*' -delete && \
	cp -R /Users/iamsahilsonawane/Projects/FlutterNest/automation_wrapper_builder/build/web/ /Users/iamsahilsonawane/Projects/FlutterNest/automation_wrapper_builder/web_app
	cd /Users/iamsahilsonawane/Projects/FlutterNest/automation_wrapper_builder/web_app && git add . && \
	git commit -m 'Deploy' && \
	git push && \
	aws s3 cp . s3://awa-builder-web --recursive --exclude ".git/*"
