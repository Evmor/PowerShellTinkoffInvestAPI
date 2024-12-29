<#
.SYNOPSIS
    Метод получения облигации по её идентификатору.
.DESCRIPTION
    Запрос получения инструмента по идентификатору.
#>
function Send-TIABondBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('BondBy')]
    param (
        # idType. Тип идентификатора инструмента. Возможные значения: figi, ticker.
        [Parameter()]
        [ValidateSet('INSTRUMENT_ID_UNSPECIFIED',
                     'INSTRUMENT_ID_TYPE_FIGI',
                     'INSTRUMENT_ID_TYPE_TICKER',
                     'INSTRUMENT_ID_TYPE_UID',
                     'INSTRUMENT_ID_TYPE_POSITION_UID')]
        [string]
        $IdType,
        # classCode. Идентификатор class_code. Обязателен при id_type = ticker.
        [Parameter()]
        [string]
        $ClassCode,
        # id. Идентификатор запрашиваемого инструмента.
        [Parameter()]
        [string]
        $Id
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/BondBy'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params =  @{
            idType = $IdType
            classCode = $ClassCode
            id = $Id
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body 
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка облигаций.
.DESCRIPTION
    Запрос получения инструментов.
#>
function Send-TIABonds {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('Bonds')]
    param (
        # Статус запрашиваемых инструментов.
        [Parameter(Mandatory)]
        [ValidateSet('INSTRUMENT_STATUS_UNSPECIFIED',
                     'INSTRUMENT_STATUS_BASE',
                     'INSTRUMENT_STATUS_ALL')]
        [string]
        $InstrumentStatus
    )
    $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/Bonds'
    $Method = 'Post'
    $Headers = @{
        "accept" = "application/json"
        "Authorization" = "Bearer $Token"
    }
    $ContentType = "application/json"
    $Params = @{
        instrumentStatus = $InstrumentStatus
    }
    $Body = $Params | ConvertTo-Json
    $Response = Invoke-WebRequest -Uri $Url `
        -Method $Method `
        -Headers $Headers
        -ContentType $ContentType
        -Body $Body
    $Response.Content | ConvertFrom-Json
}

<#
.SYNOPSIS
    Метод получения списка валют.
.DESCRIPTION
    Запрос получения инструментов.
.EXAMPLE
    Currencies -InstrumentStatus INSTRUMENT_STATUS_BASE
#>
function Send-TIACurrencies {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('Currencies')]
    param (
        # Статус запрашиваемых инструментов.
        [Parameter(Mandatory)]
        [ValidateSet('INSTRUMENT_STATUS_UNSPECIFIED',
                     'INSTRUMENT_STATUS_BASE',
                     'INSTRUMENT_STATUS_ALL')]
        [string]
        $InstrumentStatus
    )
    $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/Currencies'
    $Method = 'Post'
    $Headers = @{
        "accept" = "application/json"
        "Authorization" = "Bearer $Token"
    }
    $ContentType = "application/json"
    $Params = @{
        instrumentStatus = $InstrumentStatus
    }
    $Body = $Params | ConvertTo-Json
    $Response = Invoke-WebRequest -Uri $Url `
        -Method $Method `
        -Headers $Headers `
        -ContentType $ContentType `
        -Body $Body
    $Response.Content | ConvertFrom-Json
}

<#
.SYNOPSIS
    Метод получения валюты по её идентификатору.
.DESCRIPTION
    Запрос получения инструмента по идентификатору.
#>
function Send-TIACurrencyBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('CurrencyBy')]
    param (
        # idType. Тип идентификатора инструмента. Подробнее об идентификации инструментов: (https://tinkoff.github.io/investAPI/faq_identification/)
        [Parameter()]
        [ValidateSet('INSTRUMENT_ID_UNSPECIFIED',
                     'INSTRUMENT_ID_TYPE_FIGI',
                     'INSTRUMENT_ID_TYPE_TICKER',
                     'INSTRUMENT_ID_TYPE_UID',
                     'INSTRUMENT_ID_TYPE_POSITION_UID')]
        [string]
        $IdType,
        # classCode
        [Parameter()]
        [string]
        $ClassCode,
        # id
        [Parameter()]
        [string]
        $Id
    )
    $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/CurrencyBy'
    $Method = '/tinkoff.public.invest.api.contract.v1.InstrumentsService/CurrencyBy'
    $Headers = @{
        "accept" = "application/json"
        "Authorization" = "Bearer Token"
    }
    $ContentType  = "application/json"
    $Params = @(
        idType = $IdType
        classCode = $ClassCode
        id = $Id
    )
    $Body = $Params | ConvertTo-Json
    $Response = Invoke-WebRequest -Uri $Url `
        -Method $Method `
        -Headers $headers `
        -ContentType $ContentType `
        -Body $Body
    $Response.Content | ConvertFrom-Json
}

<#
.SYNOPSIS
    Метод редактирования списка избранных инструментов.
.DESCRIPTION
    Запрос редактирования списка избранных инструментов.
#>
function Send-TIAEditFavorites {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('EditFavorites')]
    param (
        # instruments. Массив инструментов для редактирования списка избранных инструментов.
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]
        $figi,
        # Тип действия со списком избранных инструментов.
        [Parameter(Mandatory)]
        [ValidateSet('EDIT_FAVORITES_ACTION_TYPE_UNSPECIFIED',
                     'EDIT_FAVORITES_ACTION_TYPE_ADD',
                     'EDIT_FAVORITES_ACTION_TYPE_DEL')]
        [string]
        $ActionType
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/EditFavorites'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Instruments = @()
        foreach ($Item in $figi) {
            $Instruments += @{
                figi = $Item
            }
        }
        $Params = @{
            instruments = $Instruments
            actionType = $ActionType
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения инвестиционного фонда по его идентификатору.
#>
function Send-TIAEtfBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('EtfBy')]
    param (
        # idType
        [Parameter()]
        [ValidateSet('INSTRUMENT_ID_UNSPECIFIED',
                     'INSTRUMENT_ID_TYPE_FIGI',
                     'INSTRUMENT_ID_TYPE_TICKER',
                     'INSTRUMENT_ID_TYPE_UID',
                     'INSTRUMENT_ID_TYPE_POSITION_UID')]
        [string]
        $IdType,
        # classCode
        [Parameter()]
        [string]
        $ClassCode,
        # id
        [Parameter()]
        [string]
        $Id
    )
    $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/EtfBy'
    $Method = 'Post'
    $headers = @{
        "accept" = "application/json"
        "Authorization" = "Bearer $Token"
    }
    $ContentType = "application/json"
    $Params = @{
        idType = $IdType
        classCode = $ClassCode
        id = $Id
    }
    $Body = $Params | ConvertTo-Json
    $Response = Invoke-WebRequest -Uri $Url `
        -Method $Method `
        -Headers $headers `
        -ContentType $ContentType `
        -Body $Body
    $Response.Content
}

<#
.SYNOPSIS
    Метод получения списка инвестиционных фондов.
.EXAMPLE
    Etfs -InstrumentStatus INSTRUMENT_STATUS_BASE
#>
function Send-TIAEtfs {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('Etfs')]
    param (
        # instrumentStatus
        [Parameter(Mandatory)]
        [ValidateSet('INSTRUMENT_STATUS_UNSPECIFIED',
                     'INSTRUMENT_STATUS_BASE',
                     'INSTRUMENT_STATUS_ALL')]
        [string]
        $InstrumentStatus
    )
    $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/Etfs'
    $Method = 'Post'
    $headers = @{
        "accept" = "application/json"
        "Authorization" = "Bearer $Token"
    }
    $ContentType = "application/json"
    $Params = @{
        instrumentStatus = $IinstrumentStatus
    }
    $Body = $Params | ConvertTo-Json
    $Response = Invoke-WebRequest -Uri $Url `
        -Method $Method `
        -Headers $headers `
        -ContentType $ContentType `
        -Body $Body
    $Response.Content | ConvertFrom-Json
}

<#
.SYNOPSIS
    Метод поиска инструмента.
.DESCRIPTION
    Данный метод выполняет регистронезависимый поиск по вхождению строки 'query' согласно следующему приоритету:
    - position_uid
    - uid
    - figi
    - isin
    - ticker
    - name
    Так же, используя метод FindInstrument можно найти базовый актив фьючерса. Для этого достаточно передать в query значение параметра basic_asset_position_uid, возвращаемое методами GetFutureBy и GetFutures.
.EXAMPLE
    FindInstrument -Query 'moex' -InstrumentKind INSTRUMENT_TYPE_SHARE -apiTradeAvailableFlag $true
.EXAMPLE
    FindInstrument -Query 'moex' -InstrumentKind INSTRUMENT_TYPE_SHARE -apiTradeAvailableFlag $false
.EXAMPLE
    findInstrument -Query 'moex'
#>
function Send-TIAFindInstrument {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('FindInstrument')]
    param (
        # query
        [Parameter(Mandatory)]
        [string]
        $Query,
        # Тип инструмента.
        [Parameter()]
        [String]
        [ValidateSet('INSTRUMENT_TYPE_UNSPECIFIED',
                     'INSTRUMENT_TYPE_BOND',
                     'INSTRUMENT_TYPE_SHARE',
                     'INSTRUMENT_TYPE_CURRENCY', 
                     'INSTRUMENT_TYPE_ETF', 
                     'INSTRUMENT_TYPE_FUTURES', 
                     'INSTRUMENT_TYPE_SP', 
                     'INSTRUMENT_TYPE_OPTION', 
                     'INSTRUMENT_TYPE_CLEARING_CERTIFICATE')]
        $InstrumentKind,
        # Тип значения Boolean
        [Parameter()]
        [bool]
        $apiTradeAvailableFlag = $true
    )
    $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/FindInstrument'
    $Method = 'Post'
    $Headers = @{
        "accept" = "application/json"
        "Authorization" = "Bearer $Token"
    }
    $ContentType = "application/json"
    $Params = @{
        query = $Query
        instrumentKind = $InstrumentKind
        apiTradeAvailableFlag = $apiTradeAvailableFlag
    }
    $Body = $Params | ConvertTo-Json
    $Response = Invoke-WebRequest -Uri $Url `
        -Method $Method `
        -Headers $Headers `
        -ContentType $ContentType `
        -Body $Body
    $Response.Content | ConvertFrom-Json
}

<#
.SYNOPSIS
    Метод получения фьючерса по его идентификатору.
.DESCRIPTION
    Запрос получения инструмента по идентификатору.
#>
function Send-TIAFutureBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('FutureBy')]
    param (
        # Тип идентификатора инструмента.
        [Parameter()]
        [ValidateSet('INSTRUMENT_ID_UNSPECIFIED',
                     'INSTRUMENT_ID_TYPE_FIGI',
                     'INSTRUMENT_ID_TYPE_TICKER',
                     'INSTRUMENT_ID_TYPE_UID',
                     'INSTRUMENT_ID_TYPE_POSITION_UID')]
        [string]
        $IdType,
        # classCode
        [Parameter()]
        [string]
        $ClassCode,
        # id
        [Parameter()]
        [string]
        $Id
    )
    $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/FutureBy'
    $Method = 'Post'
    $headers = @{
        "accept" = "application/json"
        "Authorization" = "Bearer $Token"
    }
    $ContentType = "application/json"
    $Params = @{
        idType = $IdType
        classCode = $ClassCode
        id = $Id
    }
    $Body = $Params | ConvertTo-Json
    $Response = Invoke-WebRequest -Uri $Url `
        -Method $Method `
        -Headers $headers `
        -ContentType $ContentType `
        -Body $Body
    $Response.Content | ConvertFrom-Json
}

<#
.SYNOPSIS
    Метод получения списка фьючерсов.
.EXAMPLE
    Futures
.EXAMPLE
    Futures -InstrumentStatus INSTRUMENT_STATUS_BASE
    #>
function Send-TIAFutures {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('Futures')]
    param (
        # instrumentStatus
        [Parameter()]
        [ValidateSet('INSTRUMENT_STATUS_UNSPECIFIED',
                     'INSTRUMENT_STATUS_BASE',
                     'INSTRUMENT_STATUS_ALL')]
        [string]
        $InstrumentStatus
    )
    $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/Futures'
    $Method = 'Post'
    $headers = @{
        "accept" = "application/json"
        "Authorization" = "Bearer $Token"
    }
    $ContentType = "application/json"
    $Params = @{
        instrumentStatus = $InstrumentStatus
    }
    $Body = $Params | ConvertTo-Json
    $Response = Invoke-WebRequest -Uri $Url `
        -Method $Method `
        -Headers $headers `
        -ContentType $ContentType `
        -Body $Body
    $Response.Content | ConvertFrom-Json
}

<#
.SYNOPSIS
    Метод получения накопленного купонного дохода по облигации.
#>
function Send-TIAGetAccruedInterests {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetAccruedInterests')]
    param (
        # figi
        [Parameter(Mandatory)]
        [string]
        $figi,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetAccruedInterests'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            figi = $figi
            from = $From
            to = $To
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения актива по его идентификатору.
.DESCRIPTION
    Запрос актива по идентификатору.
#>
function Send-TIAGetAssetBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetAssetBy')]
    param (
        # id
        [Parameter()]
        [string]
        $Id
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetAssetBy'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            id = $Id
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка активов.
.DESCRIPTION
    Запрос списка активов.
#>
function Send-TIAGetAssets {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetAssets')]
    param (
        # instrumentType
        [Parameter()]
        [ValidateSet('INSTRUMENT_TYPE_UNSPECIFIED',
                     'INSTRUMENT_TYPE_BOND',
                     'INSTRUMENT_TYPE_SHARE',
                     'INSTRUMENT_TYPE_CURRENCY',
                     'INSTRUMENT_TYPE_ETF',
                     'INSTRUMENT_TYPE_FUTURES',
                     'INSTRUMENT_TYPE_SP',
                     'INSTRUMENT_TYPE_OPTION',
                     'INSTRUMENT_TYPE_CLEARING_CERTIFICATE')]
        [string]
        $InstrumentType
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetAssets'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            instrumentType = $InstrumentType
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения графика выплат купонов по облигации.
#>
function Send-TIAGetBondCoupons {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetBondCoupons')]
    param (
        # figi
        [Parameter()]
        [string]
        $figi,
        # from. 2023-11-22T08:06:29.033Z
        [Parameter()]
        [datetime]
        $From,
        # to. 2023-11-22T08:06:29.033Z
        [Parameter()]
        [datetime]
        $To
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetBondCoupons'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params  = @{
            figi = $figi
            from = $From
            to = $To
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body 
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения бренда по его идентификатору.
#>
function Send-TIAGetBrandBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetBrandBy')]
    param (
        # id. Uid-идентификатор бренда.
        [Parameter(Mandatory)]
        [string]
        $Id
    )
    begin {}
    process {
        $Url =$BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetBrandBy'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            id = $Id
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка брендов.
#>
function Send-TIAGetBrands {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetBrands')]
    param ()
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetBrands'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body "{}"
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка стран.
#>
function Send-TIAGetCountries {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetCountries')]
    param ()
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetCountries'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body "{}"
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод для получения событий выплаты дивидендов по инструменту.
#>
function Send-TIAGetDividends {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetDividends')]
    param (
        # figi
        [Parameter()]
        [string]
        $figi,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetDividends'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType= "application/json"
        $Params = @{
            figi = $figi
            from = $From
            to = $To
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка избранных инструментов.
.DESCRIPTION
    Используя метод GetFavorites можно получить список избранных инструментов клиента. Данный метод может использоваться разработчиками для получения списка инструментов, которые робот добавил в избранное используя метод EditFavorites
#>
function Send-TIAGetFavorites {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetFavorites')]
    param ()
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetFavorites'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer t.0W029g2YPIh02aJCZlx6_9VTEdm5mTi2856FJ9Pmm4sPP4QOMO6eQblT0VQUiBZG1pBXiAvADo07-Lh8NBzSiw"
        }
        $ContentType = "application/json"
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body "{}"
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения размера гарантийного обеспечения по фьючерсам.
#>
function Send-TIAGetFuturesMargin {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetFuturesMargin')]
    param (
        # figi
        [Parameter(Mandatory)]
        [string]
        $figi
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetFuturesMargin'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            figi = $figi
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения основной информации об инструменте.
#>
function Send-TIAGetInstrumentBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetInstrumentBy')]
    param (
        # idType
        [Parameter()]
        [ValidateSet('INSTRUMENT_ID_UNSPECIFIED',
                     'INSTRUMENT_ID_TYPE_FIGI',
                     'INSTRUMENT_ID_TYPE_TICKER',
                     'INSTRUMENT_ID_TYPE_UID',
                     'INSTRUMENT_ID_TYPE_POSITION_UID')]
        [string]
        $IdType,
        # classCode
        [Parameter()]
        [string]
        $ClassCode,
        # id
        [Parameter()]
        [string]
        $Id
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/GetInstrumentBy'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            idType = $IdType
            classCode = $ClassCode
            id = $Id
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения опциона по его идентификатору.
#>
function Send-TIAOptionBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('OptionBy')]
    param (
        # idType. Тип идентификатора инструмента. Возможные значения: figi, ticker.
        [Parameter()]
        [ValidateSet('INSTRUMENT_ID_UNSPECIFIED',
                     'INSTRUMENT_ID_TYPE_FIGI',
                     'INSTRUMENT_ID_TYPE_TICKER',
                     'INSTRUMENT_ID_TYPE_UID',
                     'INSTRUMENT_ID_TYPE_POSITION_UID')]
        [string]
        $IdType,
        # classCode. Идентификатор class_code. Обязателен при id_type = ticker.
        [Parameter()]
        [string]
        $ClassCode,
        # id. Идентификатор запрашиваемого инструмента.
        [Parameter()]
        [string]
        $Id
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/OptionBy'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            idType = $IdType
            classCode = $ClassCode
            id = $Id
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Deprecated Метод получения списка опционов.
.EXAMPLE
    Options
.EXAMPLE
    Options -InstrumentStatus INSTRUMENT_STATUS_BASE
.EXAMPLE
    Options -InstrumentStatus INSTRUMENT_STATUS_ALL
#>
function Send-TIAOptions {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('Options')]
    param (
        # instrumentStatus
        [Parameter()]
        [ValidateSet('INSTRUMENT_STATUS_UNSPECIFIED',
                     'INSTRUMENT_STATUS_BASE',
                     'INSTRUMENT_STATUS_ALL')]
        [string]
        $InstrumentStatus
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/Options'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            instrumentStatus = $InstrumentStatus
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка опционов.
#>
function Send-TIAOptionsBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('OptionsBy')]
    param (
        # basicAssetUid
        [Parameter()]
        [string]
        $BasicAssetUid,
        # basicAssetPositionUid
        [Parameter()]
        [string]
        $BasicAssetPositionUid
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/OptionsBy'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            basicAssetUid = $BasicAssetUid
            basicAssetPositionUid = $BasicAssetPositionUid
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения акции по её идентификатору.
#>
function Send-TIAShareBy {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('ShareBy')]
    param (
        # idType
        [Parameter()]
        [ValidateSet('INSTRUMENT_ID_UNSPECIFIED',
                     'INSTRUMENT_ID_TYPE_FIGI',
                     'INSTRUMENT_ID_TYPE_TICKER',
                     'INSTRUMENT_ID_TYPE_UID',
                     'INSTRUMENT_ID_TYPE_POSITION_UID')]
        [string]
        $IdType,
        # classCode
        [Parameter()]
        [string]
        $ClassCode,
        # id
        [Parameter()]
        [string]
        $Id
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/ShareBy'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            idType = $IdType
            classCode = $ClassCode
            id = $Id
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
            $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка акций.
.EXAMPLE
    Shares -InstrumentStatus INSTRUMENT_STATUS_BASE
.EXAMPLE
    Shares
#>
function Send-TIAShares {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('Shares')]
    param (
        # "instrumentStatus": "INSTRUMENT_STATUS_UNSPECIFIED"
        [Parameter()]
        [ValidateSet('INSTRUMENT_STATUS_UNSPECIFIED',
                     'INSTRUMENT_STATUS_BASE',
                     'INSTRUMENT_STATUS_ALL')]
        [string]
        $InstrumentStatus
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/Shares'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            instrumentStatus = $InstrumentStatus
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
            $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения расписания торгов торговых площадок.
.EXAMPLE
    TradingSchedules
    Запущенный без параметров метод выдает график работы всех бирж начиная с текущей даты на две недели вперед.
.EXAMPLE
    TradingSchedules -Exchange 'moex'
.EXAMPLE
    TradingSchedules -From $(Get-Date)
.EXAMPLE
    TradingSchedules -To $(Get-Date)
.EXAMPLE
    TradingSchedules -Exchange 'moex' -From $(Get-Date) -To $(Get-Date)
    #>
function Send-TIATradingSchedules {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('TradingSchedules')]
    param (
        # exchange
        [Parameter()]
        [string]
        $Exchange,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.InstrumentsService/TradingSchedules'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            exchange = $Exchange
            from = $From
            to = $To
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод запроса исторических свечей по инструменту.
.EXAMPLE
    GetCandles -Interval CANDLE_INTERVAL_WEEK -figi 'BBG004730JJ5' -From $(Get-Date).AddMonths(-2) -To $(Get-Date)
#>
function Send-TIAGetCandles {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetCandles')]
    param (
        # figi
        [Parameter()]
        [string]
        $figi,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To,
        # interval
        [Parameter()]
        [ValidateSet('CANDLE_INTERVAL_UNSPECIFIED',
                     'CANDLE_INTERVAL_1_MIN',
                     'CANDLE_INTERVAL_5_MIN',
                     'CANDLE_INTERVAL_15_MIN',
                     'CANDLE_INTERVAL_HOUR',
                     'CANDLE_INTERVAL_DAY',
                     'CANDLE_INTERVAL_2_MIN',
                     'CANDLE_INTERVAL_3_MIN',
                     'CANDLE_INTERVAL_10_MIN',
                     'CANDLE_INTERVAL_30_MIN',
                     'CANDLE_INTERVAL_2_HOUR',
                     'CANDLE_INTERVAL_4_HOUR',
                     'CANDLE_INTERVAL_WEEK',
                     'CANDLE_INTERVAL_MONTH')]
        [string]
        $Interval,
        # instrumentId
        [Parameter()]
        [string]
        $InstrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataService/GetCandles'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            figi = $figi
            from = $From
            to = $To
            interval =  $Interval
            instrumentId = $InstrumentId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод запроса цен закрытия торговой сессии по инструментам.
#>
function Send-TIAGetClosePrices {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetClosePrices')]
    param (
        # instrumentId
        [Parameter(Mandatory, ValueFromPipeline)]
        [string[]]
        $InstrumentId
        #  "{`n  `"instruments`": [`n    {`n      `"instrumentId`": `"string`"`n    }`n  ]`n}"
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataService/GetClosePrices'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Instruments = @()
        foreach ($Item in $InstrumentId) {
            $Instruments += @{
                instrumentId = $Item
            }
        }
        $Params = @{
            instruments = $Instruments
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод запроса цен последних сделок по инструментам.
#>
function Send-TIAGetLastPrices {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetLastPrices')]
    param (
        # figi
        [Parameter(ValueFromPipeline)]
        [string[]]
        $figi,
        # instrumentId
        [Parameter(ValueFromPipeline)]
        [string[]]
        $instrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataService/GetLastPrices'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $figiArray = @()
        foreach ($Item in $figi) {
            $figiArray += @{
                figi = $Item
            }
        }
        $InstrumentIdArray = @()
        foreach ($Item in $instrumentId) {
            $InstrumentIdArray += @{
                instrumentId = $Item
            }
        }
        $Params = @{
            figi = $figiArray
            instrumentId = $InstrumentIdArray
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод запроса обезличенных сделок за последний час.
.EXAMPLE
    GetLastTrades -figi 'BBG004730JJ5'
#>
function Send-TIAGetLastTrades {
    [CmdletBinding()]
    [Alias('GetLastTrades')]
    param (
        # figi
        [Parameter()]
        [string]
        $figi,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To,
        # instrumentId
        [Parameter()]
        [string]
        $InstrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataService/GetLastTrades'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            figi = $figi
            from = $From
            to = $To
            instrumentId = $InstrumentId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения стакана по инструменту.
.EXAMPLE
    GetOrderBook -figi 'BBG004730JJ5' -Depth 20
    #>
function Send-TIAGetOrderBook {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetOrderBook')]
    param (
        # figi
        [Parameter()]
        [string]
        $figi,
        # depth
        [Parameter()]
        [int]
        $Depth,
        # instrumentId
        [Parameter()]
        [string]
        $InstrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataService/GetOrderBook'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            figi = $figi
            depth = $Depth
            instrumentId = $InstrumentId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод запроса статуса торгов по инструментам.
.EXAMPLE
    GetTradingStatus -figi 'BBG004730JJ5'
#>
function Send-TIAGetTradingStatus {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetTradingStatus')]
    param (
        # figi
        [Parameter()]
        [string]
        $figi,
        # InstrumentId
        [Parameter()]
        [string]
        $InstrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataService/GetTradingStatus'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            figi = $figi
            instrumentId = $InstrumentId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод запроса статуса торгов по инструментам.
#>
function Send-TIABondByTIAGetTradingStatuses {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetTradingStatuses')]
    param (
        # instrumentId
        [Parameter(ValueFromPipeline)]
        [string[]]
        $InstrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataService/GetTradingStatuses'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $InstrumentIdArray = @()
        foreach ($Item in $InstrumentId) {
            $InstrumentIdArray += @{
                instrumentId = $Item
            }
        }
        $Params = @{
            instrumentId = $InstrumentIdArray
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения брокерского отчёта.
#>
function Send-TIAGetBrokerReport {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetBrokerReport')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To,
        # taskId
        [Parameter()]
        [string]
        $TaskId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsService/GetBrokerReport'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $GenerateBrokerReportRequestHash = @{
            accountId =  $AccountId
            from = $From
            to = $To
        }
        $GetBrokerReportRequestHash = @{
            taskId = $TaskId
            page = 0
        }
        $Params = @{
            generateBrokerReportRequest = $GenerateBrokerReportRequestHash
            getBrokerReportRequest = $GetBrokerReportRequestHash
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения отчёта "Справка о доходах за пределами РФ".
#>
function Send-TIAGetDividendsForeignIssuer {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetDividendsForeignIssuer')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To,
        # taskId
        [Parameter()]
        [datetime]
        $TaskId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsService/GetDividendsForeignIssuer'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $GenerateDivForeignIssuerReportHash = @{
            accountId = $AccountId
            from = $From
            to = $To
        }
        $GetDivForeignIssuerReportHash =@{
            taskId = $TaskId
            page = 0
        }
        $Params = @{
            generateDivForeignIssuerReport = $GenerateDivForeignIssuerReportHash
            getDivForeignIssuerReport = $GetDivForeignIssuerReportHash
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка операций по счёту.
.DESCRIPTION
    Метод получения списка операций по счёту.
    При работе с данным методом необходимо учитывать [особенности взаимодействия](/investAPI/operations_problems) с данным методом.
#>
function Send-TIAGetOperations {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetOperations')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountID,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To,
        # state
        [Parameter()]
        [ValidateSet('OPERATION_STATE_UNSPECIFIED',
                     'OPERATION_STATE_EXECUTED',
                     'OPERATION_STATE_CANCELED',
                     'OPERATION_STATE_PROGRESS')]
        [string]
        $state,
        # figi
        [Parameter(figi)]
        [string]
        $figi
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsService/GetOperations'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountID
            from = $From
            to = $To
            state = $state
            figi = $figi
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка операций по счёту с пагинацией.
.DESCRIPTION
    Метод получения списка операций по счёту с пагинацией.
    При работе с данным методом необходимо учитывать [особенности взаимодействия](/investAPI/operations_problems) с данным методом.
#>
<#ДОДЕЛАТЬ!!!   Множественныйй выбор, как реализовать?
function Send-TIAGetOperationsByCursor {
    [CmdletBinding()]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # instrumentId
        [Parameter()]
        [string]
        $InstrumentId,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To,
        # cursor
        [Parameter()]
        [string]
        $Cursor,
        # limit
        [Parameter()]
        [ValidateRange('')]
        [int]
        $Limit,
        # operationTypes
        [Parameter()]
        [ValidateSet('OPERATION_TYPE_UNSPECIFIED', 'OPERATION_TYPE_INPUT', 'OPERATION_TYPE_BOND_TAX',
                     'OPERATION_TYPE_OUTPUT_SECURITIES', 'OPERATION_TYPE_OVERNIGHT', 'OPERATION_TYPE_TAX',
                     'OPERATION_TYPE_BOND_REPAYMENT_FULL', 'OPERATION_TYPE_SELL_CARD', 'OPERATION_TYPE_DIVIDEND_TAX',
                     'OPERATION_TYPE_OUTPUT', 'OPERATION_TYPE_BOND_REPAYMENT', 'OPERATION_TYPE_TAX_CORRECTION',
                     'OPERATION_TYPE_SERVICE_FEE', 'OPERATION_TYPE_BENEFIT_TAX', 'OPERATION_TYPE_MARGIN_FEE',
                     'OPERATION_TYPE_BUY', 'OPERATION_TYPE_BUY_CARD', 'OPERATION_TYPE_INPUT_SECURITIES',
                     'OPERATION_TYPE_SELL_MARGIN', 'OPERATION_TYPE_BROKER_FEE', 'OPERATION_TYPE_BUY_MARGIN',
                     'OPERATION_TYPE_DIVIDEND', 'OPERATION_TYPE_SELL', 'OPERATION_TYPE_COUPON', 'OPERATION_TYPE_SUCCESS_FEE',
                     'OPERATION_TYPE_DIVIDEND_TRANSFER', 'OPERATION_TYPE_ACCRUING_VARMARGIN',
                     'OPERATION_TYPE_WRITING_OFF_VARMARGIN', 'OPERATION_TYPE_DELIVERY_BUY', 'OPERATION_TYPE_DELIVERY_SELL',
                     'OPERATION_TYPE_TRACK_MFEE', 'OPERATION_TYPE_TRACK_PFEE', 'OPERATION_TYPE_TAX_PROGRESSIVE',
                     'OPERATION_TYPE_BOND_TAX_PROGRESSIVE', 'OPERATION_TYPE_DIVIDEND_TAX_PROGRESSIVE',
                     'OPERATION_TYPE_BENEFIT_TAX_PROGRESSIVE', 'OPERATION_TYPE_TAX_CORRECTION_PROGRESSIVE',
                     'OPERATION_TYPE_TAX_REPO_PROGRESSIVE', 'OPERATION_TYPE_TAX_REPO', 'OPERATION_TYPE_TAX_REPO_HOLD',
                     'OPERATION_TYPE_TAX_REPO_REFUND', 'OPERATION_TYPE_TAX_REPO_HOLD_PROGRESSIVE',
                     'OPERATION_TYPE_TAX_REPO_REFUND_PROGRESSIVE', 'OPERATION_TYPE_DIV_EXT',
                     'OPERATION_TYPE_TAX_CORRECTION_COUPON', 'OPERATION_TYPE_CASH_FEE', 'OPERATION_TYPE_OUT_FEE',
                     'OPERATION_TYPE_OUT_STAMP_DUTY', 'OPERATION_TYPE_OUTPUT_SWIFT', 'OPERATION_TYPE_INPUT_SWIFT',
                     'OPERATION_TYPE_OUTPUT_ACQUIRING', 'OPERATION_TYPE_INPUT_ACQUIRING', 'OPERATION_TYPE_OUTPUT_PENALTY',
                     'OPERATION_TYPE_ADVICE_FEE', 'OPERATION_TYPE_TRANS_IIS_BS', 'OPERATION_TYPE_TRANS_BS_BS',
                     'OPERATION_TYPE_OUT_MULTI', 'OPERATION_TYPE_INP_MULTI', 'OPERATION_TYPE_OVER_PLACEMENT',
                     'OPERATION_TYPE_OVER_COM', 'OPERATION_TYPE_OVER_INCOME', 'OPERATION_TYPE_OPTION_EXPIRATION')]
        [string]
        $OperationTypes
        #   "{`n  `"accountId`": `"string`",
        #   `n  `"instrumentId`": `"string`",
        #   `n  `"from`": `"2023-12-01T19:04:58.728Z`",
        #   `n  `"to`": `"2023-12-01T19:04:58.728Z`",
        #   `n  `"cursor`": `"string`",
        #   `n  `"limit`": 0,
        #   `n  `"operationTypes`": [`n    `"OPERATION_TYPE_UNSPECIFIED`"`n  ],
        #   `n  `"state`": `"OPERATION_STATE_UNSPECIFIED`",
        #   `n  `"withoutCommissions`": true,
        #   `n  `"withoutTrades`": true,
        #   `n  `"withoutOvernights`": true`n}"
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsService/GetOperationsByCursor'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            #   "{`n  `"accountId`": `"string`",
            #   `n  `"instrumentId`": `"string`",
            #   `n  `"from`": `"2023-12-01T19:04:58.728Z`",
            #   `n  `"to`": `"2023-12-01T19:04:58.728Z`",
            #   `n  `"cursor`": `"string`",
            #   `n  `"limit`": 0,
            #   `n  `"operationTypes`": [`n    `"OPERATION_TYPE_UNSPECIFIED`"`n  ],
            #   `n  `"state`": `"OPERATION_STATE_UNSPECIFIED`",
            #   `n  `"withoutCommissions`": true,
            #   `n  `"withoutTrades`": true,
            #   `n  `"withoutOvernights`": true`n}"
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertTo-Json
    }
    end {}
}
#>

<#
.SYNOPSIS
    Метод получения портфеля по счёту.
#>
function Send-TIAGetPortfolio {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetPortfolio')]
    param (
        # accountId
        [Parameter(Mandatory)]
        [string]
        $AccountId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsService/GetPortfolio'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка позиций по счёту.
#>
function Send-TIAGetPositions {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetPositions')]
    param (
        # accountId
        [Parameter(Mandatory)]
        [string]
        $AccountID
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsService/GetPositions'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountID
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения доступного остатка для вывода средств.
#>
function Send-TIAGetWithdrawLimits {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetWithdrawLimits')]
    param (
        # accountId
        [Parameter(Mandatory)]
        [string]
        $AccountID
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsService/GetWithdrawLimits'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountID
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод отмены биржевой заявки.
.DESCRIPTION
    Далеко не все торговые поручения, выставляемые на торговую площадку, могут и должны быть исполнены. Ситуация на рынке меняется динамично, поэтому торговому роботу необходима возможность отменять выставленные заявки. Для реализации этой функциональности используется метод cancelOrder.
.EXAMPLE
    CancelOrder -AccountID $AccountID -OrderId $OrderId
#>
function Send-TIACancelOrder {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('CancelOrder')]
    param (
        # AccontID. Номер счёта.
        [Parameter()]
        [string]
        $AccountID,
        # OrderID. Идентификатор заявки.
        [Parameter()]
        [string]
        $OrderId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OrdersService/CancelOrder'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountID
            orderId = $OrderId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения статуса торгового поручения.
.DESCRIPTION
    Запрос получения статуса торгового поручения.
    Несмотря на то, что статус исполнения поданного торгового поручения можно получить повторным вызовом метода выставления (с тем же параметром order_id), рекомендуется использовать для этих целей метод getOrderState. Данный метод возвращает, в том числе, стадии выполнения заявки (массив stages).
    Важно! Метод получения статуса торгового поручения не предусмотрен для получения глубокой истории и может не возвращать информацию по поручениям "старше" одних суток.
    Важно! В параметр order_id запроса метода getOrderState необходимо передавать order_id из ответа метода postOrder, т.е. биржевой идентификатор заявки.
#>
function Send-TIAGetOrderState {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetOrderState')]
    param (
        # AccountId
        [Parameter()]
        [string]
        $AccountId,
        # orderId
        [Parameter()]
        [string]
        $OrderId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OrdersService/GetOrderState'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
            orderId = $OrderId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка активных заявок по счёту.
.DESCRIPTION
    Для того чтобы торговому роботу более эффективно управлять торговыми поручениями, ему нужно иметь возможность получать список активных на данный момент заявок. Для решения этой задачи используется метод getOrders. Обратите внимание, что данный метод возвращает только активные торговые поручения, т.е. после исполнения заявка пропадает из возвращаемого списка. 
.EXAMPLE
    GetOrders -AccountId $AccountID
#>
function Send-TIAGetOrders {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetOrders')]
    param (
        # AccountId
        [Parameter(Mandatory)]
        [string]
        $AccountId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OrdersService/GetOrders'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод выставления заявки.
.DESCRIPTION
    Запрос выставления торгового поручения. Unary-метод postOrder позволяет выставлять все типы заявок (рыночные, лимитные).
    PostOrder принимает на вход параметр instrument_id - Идентификатор инструмента, принимает значения Figi или instrument_uid.
    Важно! Для исключения дублирования заявок в процессе работы используется параметр order_id, который требуется сгенерировать любым удобным способом перед вызовом метода. Если сервис получит несколько запросов с одинаковым order_id, то на биржу выставится только одно торговое поручение. Все последующие запросы, содержащие существующий order_id, будут возвращать статус этого торгового поручения. 
#>
function Send-TIAPostOrder {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('PostOrder')]
    param (
        # FIGI. Deprecated Figi-идентификатор инструмента. Необходимо использовать instrument_id.
        [Parameter()]
        [string]
        $figi,
        # quantity. Количество лотов.
        [Parameter()]
        [string]
        $Quantity,
        # Котировка - денежная сумма без указания валюты. Целая часть суммы, может быть отрицательным числом
        [Parameter()]
        [Int64]
        $Units,
        # nano
        [Parameter()]
        [int32]
        $Nano,
        # Направление операции. Направление операции.
        [Parameter()]
        [ValidateSet('ORDER_DIRECTION_UNSPECIFIED',
                     'ORDER_DIRECTION_BUY',
                     'ORDER_DIRECTION_SELL')]
        [string]
        $Direction,
        # AccountID. Номер счёта.
        [Parameter()]
        [string]
        $AccountID,
        # Тип заявки. Тип заявки.
        [Parameter()]
        [ValidateSet('ORDER_TYPE_UNSPECIFIED',
                     'ORDER_TYPE_LIMIT',
                     'ORDER_TYPE_MARKET',
                     'ORDER_TYPE_BESTPRICE')]
        [string]
        $OrderType,
        # orderId. Идентификатор запроса выставления поручения для целей идемпотентности в формате UID.
        # Максимальная длина 36 символов.
        [Parameter()]
        [string]
        $OrderId,
        # InstrumentId. Идентификатор инструмента, принимает значения Figi или Instrument_uid.
        [Parameter()]
        [string]
        $InstrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OrdersService/PostOrder'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Price = @{
            units = $Units
            nano = $Nano 
        }
        $Params = @{
            figi = $figi
            quantity = $quantity
            price = $Price
            direction = $Direction
            accountId = $AccountID
            orderType = $OrderType
            orderId = $OrderId
            instrumentId = $InstrumentId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод изменения выставленной заявки.
.DESCRIPTION
    Запрос изменения выставленной заявки.
    Для изменения уже выставленных поручений в TINKOFF INVEST API добавлен метод replaceOrder.
    Данный метод позволяет изменить существующую выставленную заявку, путем ее отмены и выставления новой заявки с измененными параметрами.
    Для использования данного метода необходимо использовать идентификатор заявки на бирже, полученный при выставлении заявки с помощью Unary-метода postOrder.
    Во время использования метода, могут произойти различные события на разных этапах исполнения. Так если ошибка произойдет из-за невозможности отмены поручения, то вернется ошибка с кодом 30059, и описание причины в message. В случаях если после отмены поручения невозможно выставить новое поручение, то вернется ошибка метода postOrder с соответствующим кодом и описанием.
#>
function Send-TIAReplaceOrder {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('ReplaceOrder')]
    param (
        # accountId. Номер счета.
        [Parameter()]
        [string]
        $AccountId,
        # orderId. Идентификатор заявки на бирже.
        [Parameter()]
        [string]
        $OrderId,
        # idempotencyKey. Новый идентификатор запроса выставления поручения для целей идемпотентности.
        # Максимальная длина 36 символов. Перезатирает старый ключ.
        [Parameter()]
        [string]
        $IdempotencyKey,
        # quantity. Количество лотов.
        [Parameter()]
        [string]
        $Quantity,
        # Котировка - денежная сумма без указания валюты. целая часть суммы, может быть отрицательным числом
        [Parameter()]
        [string]
        $Units,
        # priceType. Тип цены.
        [Parameter()]
        [ValidateSet('PRICE_TYPE_UNSPECIFIED',
                     'PRICE_TYPE_POINT',
                     'PRICE_TYPE_CURRENCY')]
        [string]
        $PriceType
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OrdersService/CancelOrder'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $Price = @{
            nano = $Nano
            units = 6
        }
        $Params = @{
            accountId = $AccountId
            orderId = $OrderId
            idempotencyKey = $IdempotencyKey
            quantity = $Quantity
            price = $Price
            priceType = $PriceType
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод отмены торгового поручения в песочнице.
#>
function Send-TIACancelSandboxOrder {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('CancelSandboxOrder')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # orderId
        [Parameter()]
        [string]
        $OrderId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/CancelSandboxOrder'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
            orderId = $OrderId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод закрытия счёта в песочнице.
#>
function Send-TIACloseSandboxAccount {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('CloseSandboxAccount')]
    param (
        # AccountId
        [Parameter(Mandatory)]
        [string]
        $AccountID
    )
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/CloseSandboxAccount'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountID
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
}

<#
.SYNOPSIS
    # Метод получения счетов в песочнице.
#>
function Send-TIAGetSandboxAccounts {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetSandboxAccounts')]
    param ()
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/GetSandboxAccounts'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body "{}"
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения операций в песочнице по номеру счёта.
#>
function Send-TIAGetSandboxOperations {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetSandboxOperations')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To,
        # state
        [Parameter()]
        [ValidateSet('OPERATION_STATE_UNSPECIFIED',
                     'OPERATION_STATE_EXECUTED',
                     'OPERATION_STATE_CANCELED',
                     'OPERATION_STATE_PROGRESS')]
        [string]
        $State,
        # figi
        [Parameter()]
        [string]
        $figi
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/GetSandboxOperations'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
            from = $From
            to = $To
            state = $State
            figi = $figi
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения операций в песочнице по номеру счета с пагинацией.
#>
<#ДОДЕЛАТЬ!!!       Множественный выбор параметра.
function Send_TIAGetSandboxOperationsByCursor {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetSandboxOperationsByCursor')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # instrumentId
        [Parameter()]
        [string]
        $InstrumentId,
        # from
        [Parameter()]
        [datetime]
        $From,
        # to
        [Parameter()]
        [datetime]
        $To,
        # cursor
        [Parameter()]
        [string]
        $Cursor,
        # operationTypes
        [Parameter()]
        [ValidateSet('OPERATION_TYPE_UNSPECIFIED', 'OPERATION_TYPE_INPUT', 'OPERATION_TYPE_BOND_TAX',
                     'OPERATION_TYPE_OUTPUT_SECURITIES', 'OPERATION_TYPE_OVERNIGHT', 'OPERATION_TYPE_TAX',
                     'OPERATION_TYPE_BOND_REPAYMENT_FULL', 'OPERATION_TYPE_SELL_CARD', 'OPERATION_TYPE_DIVIDEND_TAX',
                     'OPERATION_TYPE_OUTPUT', 'OPERATION_TYPE_BOND_REPAYMENT', 'OPERATION_TYPE_TAX_CORRECTION',
                     'OPERATION_TYPE_SERVICE_FEE', 'OPERATION_TYPE_BENEFIT_TAX', 'OPERATION_TYPE_MARGIN_FEE',
                     'OPERATION_TYPE_BUY', 'OPERATION_TYPE_BUY_CARD', 'OPERATION_TYPE_INPUT_SECURITIES',
                     'OPERATION_TYPE_SELL_MARGIN', 'OPERATION_TYPE_BROKER_FEE', 'OPERATION_TYPE_BUY_MARGIN',
                     'OPERATION_TYPE_DIVIDEND', 'OPERATION_TYPE_SELL', 'OPERATION_TYPE_COUPON', 'OPERATION_TYPE_SUCCESS_FEE',
                     'OPERATION_TYPE_DIVIDEND_TRANSFER', 'OPERATION_TYPE_ACCRUING_VARMARGIN',
                     'OPERATION_TYPE_WRITING_OFF_VARMARGIN', 'OPERATION_TYPE_DELIVERY_BUY', 'OPERATION_TYPE_DELIVERY_SELL',
                     'OPERATION_TYPE_TRACK_MFEE', 'OPERATION_TYPE_TRACK_PFEE', 'OPERATION_TYPE_TAX_PROGRESSIVE',
                     'OPERATION_TYPE_BOND_TAX_PROGRESSIVE', 'OPERATION_TYPE_DIVIDEND_TAX_PROGRESSIVE',
                     'OPERATION_TYPE_BENEFIT_TAX_PROGRESSIVE', 'OPERATION_TYPE_TAX_CORRECTION_PROGRESSIVE',
                     'OPERATION_TYPE_TAX_REPO_PROGRESSIVE', 'OPERATION_TYPE_TAX_REPO', 'OPERATION_TYPE_TAX_REPO_HOLD',
                     'OPERATION_TYPE_TAX_REPO_REFUND', 'OPERATION_TYPE_TAX_REPO_HOLD_PROGRESSIVE',
                     'OPERATION_TYPE_TAX_REPO_REFUND_PROGRESSIVE', 'OPERATION_TYPE_DIV_EXT',
                     'OPERATION_TYPE_TAX_CORRECTION_COUPON', 'OPERATION_TYPE_CASH_FEE', 'OPERATION_TYPE_OUT_FEE',
                     'OPERATION_TYPE_OUT_STAMP_DUTY', 'OPERATION_TYPE_OUTPUT_SWIFT', 'OPERATION_TYPE_INPUT_SWIFT',
                     'OPERATION_TYPE_OUTPUT_ACQUIRING', 'OPERATION_TYPE_INPUT_ACQUIRING', 'OPERATION_TYPE_OUTPUT_PENALTY',
                     'OPERATION_TYPE_ADVICE_FEE', 'OPERATION_TYPE_TRANS_IIS_BS', 'OPERATION_TYPE_TRANS_BS_BS',
                     'OPERATION_TYPE_OUT_MULTI', 'OPERATION_TYPE_INP_MULTI', 'OPERATION_TYPE_OVER_PLACEMENT',
                     'OPERATION_TYPE_OVER_COM', 'OPERATION_TYPE_OVER_INCOME', 'OPERATION_TYPE_OPTION_EXPIRATION')]
        [string]
        $OperationTypes,
        # state
        [Parameter()]
        [ValidateSet('OPERATION_STATE_UNSPECIFIED',
                     'OPERATION_STATE_EXECUTED',
                     'OPERATION_STATE_CANCELED',
                     'OPERATION_STATE_PROGRESS')]
        [string]
        $State,
        # withoutCommissions
        [Parameter()]
        [bool]
        $WithoutCommissions,
        # withoutTrades
        [Parameter()]
        [bool]
        $WithoutTrades,
        # withoutOvernights
        [Parameter()]
        [bool]
        $WithoutOvernights
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/GetSandboxOperationsByCursor'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
            instrumentId = $InstrumentId
            from = $From
            to = $To
            cursor = $Cursor
            limit = 0
            operationTypes = $OperationTypes
            state = $State
            withoutCommissions = $WithoutCommissions
            withoutTrades =  $WithoutTrades
            withoutOvernights = $WithoutOvernights
            # "{`n  `"accountId`": `"string`",
            #   `n  `"instrumentId`": `"string`",
            #   `n  `"from`": `"2023-12-02T05:50:40.099Z`",
            #   `n  `"to`": `"2023-12-02T05:50:40.099Z`",
            #   `n  `"cursor`": `"string`",
            #   `n  `"limit`": 0,
            #   `n  `"operationTypes`": [
            #       `n    `"OPERATION_TYPE_UNSPECIFIED`"`n  ],
            #   `n  `"state`": `"OPERATION_STATE_UNSPECIFIED`",
            #   `n  `"withoutCommissions`": true,
            #   `n  `"withoutTrades`": true,
            #   `n  `"withoutOvernights`": true`n}"        
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}
#>

<#
.SYNOPSIS
    Метод получения статуса заявки в песочнице.
#>
function Send-TIAGetSandboxOrderState {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetSandboxOrderState')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # orderId
        [Parameter()]
        [string]
        $OrderId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/GetSandboxOrderState'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
            orderId = $OrderId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка активных заявок по счёту в песочнице.
#>
function Send-TIAGetSandboxOrders {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetSandboxOrders')]
    param (
        # AccountID
        [Parameter(Mandatory)]
        [String]
        $AccountID
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/GetSandboxOrders'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountID
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения портфолио в песочнице.
#>
function Send-TIAGetSandboxPortfolio {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetSandboxPortfolio')]
    param (
        # AccountID
        [Parameter()]
        [string]
        $AccountID,
        # Currency
        [Parameter()]
        [ValidateSet('RUB')]
        [string]
        $Currency
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/GetSandboxPortfolio'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountID
            currency = $Currency
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения позиций по виртуальному счёту песочницы.
#>
function Send-TIAGetSandboxPositions {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetSandboxPositions')]
    param (
        # AccountID
        [Parameter()]
        [string]
        $AccountID
    )
    begin {}
    process {
        $Url = $BaseUri + '/rest/tinkoff.public.invest.api.contract.v1.SandboxService/GetSandboxPositions'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = $ContentType
        $Params = @{
            accountId = $AccountID
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    # Метод получения доступного остатка для вывода средств в песочнице.
#>
function Send-TIAGetSandboxWithdrawLimits {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetSandboxWithdrawLimits')]
    param (
        # AccountID
        [Parameter()]
        [string]
        $AccountID
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/GetSandboxWithdrawLimits'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountID
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    # Метод регистрации счёта в песочнице.
#>
function Send-TIAOpenSandboxAccount {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('OpenSandboxAccount')]
    param ()
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/OpenSandboxAccount'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body "{}"
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод выставления торгового поручения в песочнице.
#>
function Send-TIAPostSandboxOrder {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('PostSandboxOrder')]
    param (
        # figi
        [Parameter()]
        [string]
        $figi,
        # quantity
        [Parameter()]
        [Int64]
        $Quantity,
        # units
        [Parameter()]
        [Int64]
        $Units,
        # direction
        [Parameter()]
        [ValidateSet('ORDER_DIRECTION_UNSPECIFIED',
                     'ORDER_DIRECTION_BUY',
                     'ORDER_DIRECTION_SELL')]
        [string]
        $Direction,
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # orderType
        [Parameter()]
        [ValidateSet('ORDER_TYPE_UNSPECIFIED',
                     'ORDER_TYPE_LIMIT',
                     'ORDER_TYPE_MARKET',
                     'ORDER_TYPE_BESTPRICE')]
        [string]
        $OrderType,
        # orderId
        [Parameter()]
        [string]
        $OrderId,
        # instrumentId
        [Parameter(instrumentId)]
        [string]
        $InstrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/PostSandboxOrder'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Price = @{
            nano = 6
            units = $Units
        }
        $Params = @{
            figi = $figi
            quantity = $Quantity
            price = $Price
            direction = $Direction
            accountId = $AccountId
            orderType = $OrderType
            orderId = $OrderId
            instrumentId = $InstrumentId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод изменения выставленной заявки в песочнице.
#>
function Send-TIAReplaceSandboxOrder {
    [CmdletBinding(PositionalBinding=$false)]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # orderId
        [Parameter()]
        [string]
        $OrderId,
        # idempotencyKey
        [Parameter()]
        [string]
        $idempotencyKey,
        # quantity
        [Parameter()]
        [string]
        $Quantity,
        # units
        [Parameter()]
        [Int64]
        $Units,
        # priceType
        [Parameter()]
        [ValidateSet('PRICE_TYPE_UNSPECIFIED',
                     'PRICE_TYPE_POINT',
                     'PRICE_TYPE_CURRENCY')]
        [string]
        $PriceType
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/ReplaceSandboxOrder'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Price = @{
            nano = 6
            units = $Units
        }
        $Params = @{
            accountId =  $AccountId
            orderId = $OrderId
            idempotencyKey = $idempotencyKey
            quantity = $Quantity
            price = $Price
            priceType = $PriceType
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод пополнения счёта в песочнице.
#>
function Send-TIASandboxPayIn {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('SandboxPayIn')]
    param (
        # AccountId - Номер счета для пополнения
        [Parameter(Mandatory)]
        [string]
        $AccountID,
        # Currency - Валюта пополнения. По умолчанию 'RUB' (рубли).
        [Parameter(Mandatory)]
        [ValidateSet('RUB')]
        [string]
        $Currency,
        # Units - Количество вносимой валюты. В данном случае количество рублей.
        [Parameter(Mandatory)]
        [int]
        $Units
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.SandboxService/SandboxPayIn'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Amount = @{
            nano = 5
            currency = $Currency
            units = $Units
        }
        $Params = @{
            accountId = $AccountID
            amount = $Amount
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-RestMethod -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод отмены стоп-заявки.
#>
function Send-TIACancelStopOrder {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('CancelStopOrder')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # stopOrderId
        [Parameter()]
        [string]
        $StopOrderId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.StopOrdersService/CancelStopOrder'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
            stopOrderId = $StopOrderId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения списка активных стоп заявок по счёту.
#>
function Send-TIAGetStopOrders {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetStopOrders')]
    param (
        # accountId
        [Parameter()]
        [string]
        $AccountId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.StopOrdersService/GetStopOrders'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод выставления стоп-заявки.
#>
function Send-TIAPostStopOrder {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('PostStopOrder')]
    param (
        # figi
        [Parameter()]
        [string]
        $figi,
        # quantity
        [Parameter()]
        [string]
        $Quantity,
        # PriceUnits
        [Parameter()]
        [Int64]
        $PriceUnits,
        # stopPriceUnits
        [Parameter()]
        [Int64]
        $StopPriceUnits,
        # direction
        [Parameter()]
        [ValidateSet('STOP_ORDER_DIRECTION_UNSPECIFIED',
                     'STOP_ORDER_DIRECTION_BUY',
                     'STOP_ORDER_DIRECTION_SELL')]
        [string]
        $Direction,
        # accountId
        [Parameter()]
        [string]
        $AccountId,
        # expirationType
        [Parameter()]
        [ValidateSet('STOP_ORDER_EXPIRATION_TYPE_UNSPECIFIED',
                     'STOP_ORDER_EXPIRATION_TYPE_GOOD_TILL_CANCEL',
                     'STOP_ORDER_EXPIRATION_TYPE_GOOD_TILL_DATE')]
        [string]
        $ExpirationType,
        # stopOrderType
        [Parameter()]
        [ValidateSet('STOP_ORDER_TYPE_UNSPECIFIED',
                      'STOP_ORDER_TYPE_TAKE_PROFIT',
                      'STOP_ORDER_TYPE_STOP_LOSS',
                      'STOP_ORDER_TYPE_STOP_LIMIT')]
        [string]
        $StopOrderType,
        # expireDate
        [Parameter()]
        [datetime]
        $ExpireDate,
        # instrumentId
        [Parameter()]
        [string]
        $InstrumentId
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.StopOrdersService/PostStopOrder'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Price = @{
            nano = 6
            units = $PriceUnits
        }
        $StopPrice = @{
            nano = 6
            units = $StopPriceUnits
        }
        $Params = @{
            figi = $figi
            quantity = $Quantity
            price = $Price
            stopPrice = $StopPrice
            direction = $Direction
            $AccountId = $AccountId
            expirationType = $ExpirationType
            stopOrderType = $StopOrderType
            expireDate = $ExpireDate
            instrumentId = $InstrumentId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения счетов пользователя.
#>
function Send-TIAGetAccounts {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetAccounts')]
    param ()
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.UsersService/GetAccounts'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body "{}"
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Метод получения информации о пользователе.
#>
function Send-TIAGetInfo {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetInfo')]
    param ()
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.UsersService/GetInfo'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body "{}"
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Расчёт маржинальных показателей по счёту.
.EXAMPLE
    GetMarginAttributes -AccountId $AccountID
#>
function Send-TIAGetMarginAttributes {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetMarginAttributes')]
    param (
        # $AccountId
        [Parameter()]
        [string]
        $AccountId
    )
    begin {}
    process {
        $Url = $BaseUri + '/rest/tinkoff.public.invest.api.contract.v1.UsersService/GetMarginAttributes'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accountId = $AccountId
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    # Запрос тарифа пользователя.
#>
function Send-TIAGetUserTariff {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('GetUserTariff')]
    param ()
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.UsersService/GetUserTariff'
        $Method = 'Post'
        $Headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $token"
        }
        $ContentType = "application/json"
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $Headers `
            -ContentType $ContentType `
            -Body "{}"
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Server-side стрим предоставления биржевой информации.
#>
<#ДОДЕЛАТЬ!!!   Разобрать, что здесь вообще намешано.
function Send-TIAMarketDataServerSideStream {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('MarketDataServerSideStream')]
    param (
        # "{`n  `"subscribeCandlesRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"interval`": `"SUBSCRIPTION_INTERVAL_UNSPECIFIED`",
        #               `n        `"instrumentId`": `"string`"`n      }`n    ],
        #       `n    `"waitingClose`": true`n  },
        #   `n  `"subscribeOrderBookRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"depth`": 0,
        #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
        #   `n  `"subscribeTradesRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
        #   `n  `"subscribeInfoRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
        #   `n  `"subscribeLastPriceRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  }`n}"
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataStreamService/MarketDataServerSideStream'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            # "{`n  `"subscribeCandlesRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"interval`": `"SUBSCRIPTION_INTERVAL_UNSPECIFIED`",
            #               `n        `"instrumentId`": `"string`"`n      }`n    ],
            #       `n    `"waitingClose`": true`n  },
            #   `n  `"subscribeOrderBookRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"depth`": 0,
            #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
            #   `n  `"subscribeTradesRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
            #   `n  `"subscribeInfoRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
            #   `n  `"subscribeLastPriceRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  }`n}"
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content| ConvertFrom-Json
    }
    end {}
}
#>

<#
.SYNOPSIS
    Bi-directional стрим предоставления биржевой информации.
#>
<#ДОДЕЛАТЬ!!!       Мега намешано. Фиг разберешь.
function Send-TIAMarketDataStream {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('MarketDataStream')]
    param (
        # "{`n  `"subscribeCandlesRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"interval`": `"SUBSCRIPTION_INTERVAL_UNSPECIFIED`",
        #               `n        `"instrumentId`": `"string`"`n      }`n    ],
        #       `n    `"waitingClose`": true`n  },
        #   `n  `"subscribeOrderBookRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"depth`": 0,
        #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
        #   `n  `"subscribeTradesRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
        #   `n  `"subscribeInfoRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
        #   `n  `"subscribeLastPriceRequest`": {
        #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
        #       `n    `"instruments`": [
        #           `n      {
        #               `n        `"figi`": `"string`",
        #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
        #   `n  `"getMySubscriptions`": {}`n}"
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.MarketDataStreamService/MarketDataStream'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            # "{`n  `"subscribeCandlesRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"interval`": `"SUBSCRIPTION_INTERVAL_UNSPECIFIED`",
            #               `n        `"instrumentId`": `"string`"`n      }`n    ],
            #       `n    `"waitingClose`": true`n  },
            #   `n  `"subscribeOrderBookRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"depth`": 0,
            #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
            #   `n  `"subscribeTradesRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
            #   `n  `"subscribeInfoRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
            #   `n  `"subscribeLastPriceRequest`": {
            #       `n    `"subscriptionAction`": `"SUBSCRIPTION_ACTION_UNSPECIFIED`",
            #       `n    `"instruments`": [
            #           `n      {
            #               `n        `"figi`": `"string`",
            #               `n        `"instrumentId`": `"string`"`n      }`n    ]`n  },
            #   `n  `"getMySubscriptions`": {}`n}"
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}
#>

<#
.SYNOPSIS
    Server-side stream обновлений портфеля
#>
function Send-TIAPortfolioStream {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('PortfolioStream')]
    param (
        # accounts
        [Parameter()]
        [string[]]
        $Accounts
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsStreamService/PortfolioStream'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accounts = @($Accounts)
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Server-side stream обновлений информации по изменению позиций портфеля
#>
function Send-TIAPositionsStream {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('PositionsStream')]
    param (
        # accounts
        [Parameter()]
        [string]
        $Accounts
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OperationsStreamService/PositionsStream'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params = @{
            accounts = $Accounts
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}

<#
.SYNOPSIS
    Stream сделок пользователя
#>
<#ДОДЕЛАТЬ !!! Пока не работает.
function Send-TIATradesStream {
    [CmdletBinding(PositionalBinding=$false)]
    [Alias('TradesStream')]
    param (
        # accounts
        [Parameter()]
        [string]
        $Accounts
    )
    begin {}
    process {
        $Url = $BaseUri + '/tinkoff.public.invest.api.contract.v1.OrdersStreamService/TradesStream'
        $Method = 'Post'
        $headers = @{
            "accept" = "application/json"
            "Authorization" = "Bearer $Token"
        }
        $ContentType = "application/json"
        $Params=@{
            accounts = $Accounts
        }
        $Body = $Params | ConvertTo-Json
        $Response = Invoke-WebRequest -Uri $Url `
            -Method $Method `
            -Headers $headers `
            -ContentType $ContentType `
            -Body $Body
        $Response.Content | ConvertFrom-Json
    }
    end {}
}
#>

