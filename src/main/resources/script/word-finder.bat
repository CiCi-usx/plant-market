# 设置要搜索的文件夹路径（请修改为你的实际路径）
$searchPath = "D:\schools\web\exp4\src\main\webapp\css"

# 搜索所有文件，查找包含 ".error" 字样的行
Get-ChildItem -Path $searchPath -Recurse -File | ForEach-Object {
    $matches = Select-String -Path $_.FullName -Pattern "\.error" -CaseSensitive:$false
    if ($matches) {
        Write-Host "Found in: $($_.FullName)" -ForegroundColor Yellow
        $matches | ForEach-Object {
            Write-Host "  Line $($_.LineNumber): $($_.Line.Trim())" -ForegroundColor Gray
        }
    }
}