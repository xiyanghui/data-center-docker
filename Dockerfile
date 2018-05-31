
FROM ubuntu:18.04

# 配置基础环境
## for apt to be noninteractive
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

## preesed tzdata, update package index, upgrade packages and install needed software
RUN echo "tzdata tzdata/Areas select Asia" > /tmp/preseed.txt \
  && echo "tzdata tzdata/Zones/Asia select Shanghai" >> /tmp/preseed.txt \
  && debconf-set-selections /tmp/preseed.txt  \
  && apt-get update && apt-get install -y \
    tzdata \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

# 安装 php7.2
RUN apt-get update && apt-get install -y \
    php \
    php-cli \
    php-fpm \
    php-xml \
    php-mbstring \
    php-curl \
    php-dev \
    php-pear \
    php-xdebug \
    php-mongodb \
    php-redis \
  && rm -rf /var/lib/apt/lists/* && apt-get clean

# 安装 composer 相关
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    wget \
  && rm -rf /var/lib/apt/lists/* && apt-get clean \
  && wget -O /usr/local/bin/composer https://getcomposer.org/download/1.6.2/composer.phar \
  && chmod +x /usr/local/bin/composer

# 安装 nginx
RUN apt-get update && apt-get install -y \
    nginx \
  && rm -rf /var/lib/apt/lists/*

