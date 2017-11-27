#!/bin/bash
cd /data
mkdir scrapy_env
cd scrapy_env/
cat>quotes_spider.py<<EOF
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import scrapy


class QuotesSpider(scrapy.Spider):
    name = "quotes"
    start_urls = [
        'http://quotes.toscrape.com/tag/humor/',
    ]

    def parse(self, response):
        for quote in response.css('div.quote'):
            yield {
                'text': quote.css('span.text::text').extract_first(),
                'author': quote.xpath('span/small/text()').extract_first(),
            }

        next_page = response.css('li.next a::attr("href")').extract_first()
        if next_page is not None:
            yield response.follow(next_page, self.parse)
EOF

virtualenv -p /usr/bin/python3 --no-site-packages venv
source venv/bin/activate
pip3 install Scrapy
scrapy runspider quotes_spider.py -o quotes.json
deactivate

cd