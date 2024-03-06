function Find-SystemUpdate {
    # Создаем объект-сессию обновления
    $updateSession = New-Object -ComObject Microsoft.Update.Session
    $updateSearcher = $updateSession.CreateUpdateSearcher()

    # Проверяем наличие обновлений
    $searchResult = $updateSearcher.Search("IsInstalled=0 and Type='Software'")

    # Выводим количество доступных обновлений
    Write-Host "Найдено обновлений: $($searchResult.Updates.Count)"

    # Если обновления найдены, сообщаем об этом и предлагаем их установить
    if ($searchResult.Updates.Count -gt 0) {
        # Вывод сообщения о необходимости обновления
        Write-Host "Обновления доступны. Рекомендуется обновить систему."
        # Открываем Параметры с окном Центра обновлений
        Start-Process "ms-settings:windowsupdate"
        # Остановка скрипта
        return $true
    } else {
        Write-Host "Доступных обновлений нет."
        return $false
    }
}

Export-ModuleMember -Function 'Find-SystemUpdate'