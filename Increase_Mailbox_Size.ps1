Connect-ExchangeOnline

Set-Mailbox 'user' -ProhibitSendQuota '#GB' -ProhibitSendReceiveQuota '#GB' -IssueWarningQuota '#GB'
