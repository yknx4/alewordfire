FROM amd64/ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm
ENV LC_ALL en_US.utf8
ENV LANGUAGE en_US.utf8
ENV LANG en_US.utf8

RUN apt-get update && apt-get install -y grep autoconf build-essential bash git curl openssh-server locales
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb && apt-get update && apt-get install -y esl-erlang elixir

RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

RUN ssh-keygen -A
RUN mkdir -p /run/sshd

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN mix local.hex --force
RUN mix local.rebar --force

RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && bash nodesource_setup.sh && apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends yarn

RUN node --version
RUN yarn --version

VOLUME /edeliver/aleworld
CMD /usr/sbin/sshd -D
EXPOSE 22
