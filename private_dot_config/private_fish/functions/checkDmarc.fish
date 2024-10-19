# Function for searching a whole lot of DMARC reports for failures
function checkDmarc
  for i in *.gz
    gunzip $i
  end

  for i in *.zip
    unzip $i && rm $i
  end

  ag "(?<!spf>)(?<!soft)fail" *.xml -B 6 -A 12 --print-all-files
end
