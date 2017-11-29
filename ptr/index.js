const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({ args: ['--no-sandbox', '--disable-setuid-sandbox'] })
  const page = await browser.newPage()
  await page.goto('http://zx.bjmemc.com.cn/getAqiList.shtml?timestamp=1511744710734')
  
  //await page.goto('http://106.37.208.233:20035/')
  await page.screenshot({path: 'example.png'})

  await browser.close()
})()
