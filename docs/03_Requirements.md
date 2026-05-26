# NFA-AutoInstall 需求規格書

## 專案目標

建立一套 PowerShell 自動化工具。

協助資訊人員快速完成：

- 軟體安裝
- 軟體檢查
- 印表機檢查
- Office 檢查
- Trend Micro 檢查
- 安裝報告產生

降低人工檢查時間。

---

# 功能需求

## FR-001 電腦資訊檢查

系統應能取得：

- 電腦名稱
- 使用者名稱
- 網域名稱
- Windows 版本

---

## FR-002 Office 檢查

系統應能確認：

- Office 是否存在
- Office 版本

檢查項目：

- Word
- Excel
- Outlook
- PowerPoint

---

## FR-003 Trend Micro 檢查

系統應能確認：

- Apex One
- Vision One

是否安裝完成。

---

## FR-004 印表機檢查

系統應確認：

- Printer01
- Printer02
- Printer03
- Printer04
- Printer05
- Microsoft Print to PDF

是否存在。

---

## FR-005 安裝結果報告

系統應輸出：

- 檢查時間
- 電腦名稱
- 檢查結果

格式：

- TXT
- CSV

---

# 非功能需求

## NFR-001

執行時間不得超過 30 秒。

---

## NFR-002

支援：

- Windows 10
- Windows 11

---

## NFR-003

需支援 PowerShell 5.1

---

## NFR-004

無需安裝額外軟體即可執行。