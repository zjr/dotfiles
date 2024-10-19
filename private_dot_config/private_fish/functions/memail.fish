function memail
  set ts (epoch)
  set mail zach+$ts@adxsoftware.com
  echo $ts | pbcopy
  echo $mail
  echo $ts
end
