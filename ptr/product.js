const async = require('async')
const puppeteer = require('puppeteer')
const devices = require('puppeteer/DeviceDescriptors')

const items = ['561586866175', '561586866176']

async function crawler (itemId, callback) {
  const browser = await puppeteer.launch({ args: ['--no-sandbox', '--disable-setuid-sandbox'] })
  const page = await browser.newPage()
  const userAgent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.0 Mobile/14G60 Safari/602.1'
  await page.setUserAgent(userAgent)
  await page.emulate(devices['iPhone 6'])
  const customHeaders = {
    Accept: '*/*',
    Connection: 'keep-alive',
    'Accept-Encoding': 'gzip, deflate',
    'Accept-Language': 'zh-cn',
    Referer: `http://h5.m.taobao.com/awp/core/detail.htm?id=${itemId}`
  }

  await page.setExtraHTTPHeaders(customHeaders)
  const url = `http://h5api.m.taobao.com/h5/mtop.taobao.detail.getdetail/6.0/?data=%7B%22exParams%22%3A%22%7B%5C%22id%5C%22%3A%5C%22%5C%22%7D%22%2C%22itemNumId%22%3A%22${itemId}%22%7D`
  await page.goto(url)

  const aHandle = await page.evaluateHandle(() => document.body)
  const resultHandle = await page.evaluateHandle(body => body.textContent, aHandle)
  console.log(await resultHandle.jsonValue())
  await resultHandle.dispose()
  await browser.close()
  callback
}

async.eachSeries(items, crawler, (err) => {
  console.log(err)
})
