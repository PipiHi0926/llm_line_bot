# llm_line_bot

## 流程
1. 進入 Line Developers官方網站
- [LINE Developers Console](https://developers.line.biz/zh-hant/)

2. 登入，選擇「使用LINE帳號登入」

3. 登入自己的LINE帳號密碼、身分驗證

4. 建立LINE開發者帳戶

![alt text](images\image.png)

5. 如下，建立一個provider

![alt text](images\image-1.png)

6. 左側可選擇剛建完的provider

![alt text](images\image-2.png)

7. 去Channels頁面，選擇 Create a Messaging API channel

![alt text](images\image-3.png)

8. 填入資訊，如line-bot名稱、圖片、說明 (之後都可修改)

![alt text](images\image-4.png)

- Privacy policy URL，可不填 (提供網址連結到企業或網站的隱私政策頁面)

- Terms of use URL (訪問網站或應用程式的使用條款頁面的網址)

9. 確認建立

![alt text](images\image-5.png)

10. 回到channel介面，可以看到成功新增channel (為你的應用程式或服務創建一個專用的通道)

![alt text](images\image-6.png)

11. 點進去建立完的channel

![alt text](images\image-7.png)

12. 切到 Messaging API 頁面

![alt text](images\image-9.png)

13. 滑到最下面點選旁邊issue，即可生成 LINE_CHANNEL_ACCESS_TOKEN

![alt text](images\image-11.png)

14. 再切到Basic settings，滑到最下面 

![alt text](images\image-12.png)


15. 即可取得Channel secret
![alt text](images\image-13.png)







## Heroku 步驟

首先先到Heroko 申請一個帳號
網站:https://www.heroku.com/
![alt text](image-14.png)


![alt text](image-15.png)




line_venv\Scripts\activate 

python llm_line_bot\main.py