FROM ruby:2.7

RUN mkdir /capybara_evaluator_action
COPY . /capybara_evaluator_action
WORKDIR /capybara_evaluator_action
RUN chmod +x entrypoint.sh

RUN apt-get update && apt-get install -y packagekit-gtk3-module x11vnc libdbus-glib-1-2
RUN wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-72.0-ssl&os=linux64&lang=en-US"
RUN tar xjf FirefoxSetup.tar.bz2 -C /opt/
RUN ln -s /opt/firefox/firefox-bin /usr/bin/firefox
RUN rm FirefoxSetup.tar.bz2
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz
RUN tar -xvzf geckodriver*
RUN chmod +x geckodriver
RUN mv geckodriver /usr/local/bin/
RUN rm geckodriver-v0.26.0-linux64.tar.gz
RUN bundle install

ENV RUBYOPT="-KU -E utf-8:utf-8"

ENTRYPOINT ["/capybara_evaluator_action/entrypoint.sh"]
