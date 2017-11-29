'use strict'

const puppeteer = require('puppeteer');
const devices = require('puppeteer/DeviceDescriptors')
(async () => {
  console.time('puppeteer.launch')
  const browser = await puppeteer.launch({ignoreHTTPSErrors: true, args: ['--no-sandbox', '--disable-setuid-sandbox']})
  console.timeEnd('puppeteer.launch')
  console.time('browser.newPage')
  const page = await browser.newPage()
  console.timeEnd('browser.newPage')

  const userAgent = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.75 Safari/537.36'
  const customHeaders = {
    Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-CN,zh;q=0.9',
    'Cache-Control': 'max-age=0',
    Connection: 'keep-alive',
    Host: 'm.zq12369.com',
    Referer: 'https://m.zq12369.com/cityselect.php',
    'Upgrade-Insecure-Requests': '1'
  }


  const userAgent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.0 Mobile/14G60 Safari/602.1'
  const customHeaders = {
    Accept: '*/*',
    Connection: 'keep-alive',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-cn',
    Referer: 'https://m.zq12369.com/cityselect.php',
    Host: 'm.zq12369.com',
  }
  console.time('page.setUserAgent')
  await page.setUserAgent(userAgent)
  await page.setExtraHTTPHeaders(customHeaders)
  console.timeEnd('page.setUserAgent')
  console.time('page.goto')
  // await page.goto('http://datacenter.mep.gov.cn/index!environmentAirHourDetail.action?cityName=%E5%8C%97%E4%BA%AC%E5%B8%82&cityCode=110000&searchTime=2017-11-26%2006:00:00',{waitUntil: 'domcontentloaded'})
  // await page.goto('http://m.air-level.com/air/beijing/',{waitUntil: 'domcontentloaded'});
  // await page.goto('http://www.stateair.net/web/post/1/2.html',{waitUntil: 'domcontentloaded'});
  // await page.goto('https://www.aqistudy.cn/')
  await page.goto('https://m.zq12369.com/cityaqi.php?city=%E4%B8%8A%E6%B5%B7', {waitUntil: 'domcontentloaded'})
  console.timeEnd('page.goto')
  /*
  console.time('evaluate')
  const datas = await page.evaluate(() => {
    const anchors = Array.from(document.querySelectorAll('p.text_center'))
    return anchors.map(anchor => anchor.textContent)
  })
  console.log(datas.join('\n'))
  console.timeEnd('evaluate')
  */
  await page.screenshot({path: 'example.png'})
  console.time('browser.close')
  await browser.close()
  console.timeEnd('browser.close')
})()
