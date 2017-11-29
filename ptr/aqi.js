const puppeteer = require('puppeteer');

(async () => {
  console.time('total')
  console.time('puppeteer.launch')
  const browser = await puppeteer.launch({ignoreHTTPSErrors: true, args: ['--no-sandbox', '--disable-setuid-sandbox']})
  console.timeEnd('puppeteer.launch')

  console.time('browser.newPage')
  const page = await browser.newPage()
  console.timeEnd('browser.newPage')

  await page.setViewport({width: 1920, height: 777})

  console.time('page.setUserAgent')
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
  await page.setUserAgent(userAgent)
  await page.setExtraHTTPHeaders(customHeaders)
  console.timeEnd('page.setUserAgent')

  console.time('page.goto')
  await page.goto('https://m.zq12369.com/cityaqi.php?city=%E4%B8%8A%E6%B5%B7', {waitUntil: 'domcontentloaded'})
  console.timeEnd('page.goto')

  // await page.waitFor(500)

  await page.screenshot({path: 'example.png', fullPage: true})

  await page.waitForSelector('.pointtbody2 tr')
  const datas = await page.evaluate(() => {
    let updatetime = document.querySelector('.updatetime').textContent

    let reg = /[1-9][0-9]*/g
    let numList = updatetime.match(reg).join('').concat('00')
    updatetime = numList

    const pm25 = document.querySelector('.item_pm2_5').textContent
    const pm10 = document.querySelector('.item_pm10').textContent
    const so2 = document.querySelector('.item_so2').textContent
    const no2 = document.querySelector('.item_no2').textContent
    const co = document.querySelector('.item_co').textContent
    const o3 = document.querySelector('.item_o3').textContent

    const name = Array.from(document.querySelectorAll('.pointtbody tr td a')).map(el => el.textContent)
    let targets = Array.from(document.querySelectorAll('.pointtabledata tbody tr td')).map(el => el.textContent)
    let result = []
    let count = 0
    while (targets.length > 0) {
      result[count] = targets.splice(0, 8)
      count++
    }

    return {updatetime: updatetime, pm25: pm25, pm10: pm10, so2: so2, no2: no2, co: co, o3: o3, name: name, result: result}
  })
  console.log(datas)

  console.time('browser.close')
  await browser.close()
  console.timeEnd('browser.close')
  console.timeEnd('total')
})()
