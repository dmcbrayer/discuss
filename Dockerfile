FROM elixir:latest

MAINTAINER Daniel McBrayer <daniel@roundtabledev.com>

RUN mix local.hex --force

RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez

RUN mix local.rebar --force

# install node
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh  
RUN bash nodesource_setup.sh  
RUN apt-get install nodejs

# create app folder
RUN mkdir /app  
COPY . /app  
WORKDIR /app

# install dependencies
RUN mix deps.get

# install node dependencies
RUN npm install  
RUN node node_modules/brunch/bin/brunch build

# run phoenix in *dev* mode on port 4000
CMD mix phoenix.server  