# NFT Marketplace Demo

This is a demo of NFT contract ERC721 and Marketplace contract with a simple frontend.


## Installation

Frontend

``` 
yarn install
yarn dev
```

Deploy

create a new file `.secret` at `/` and paste your privite key.

This privite key will be your contract owner
```
mkdir .secret
```
`hardhat.config.js` is using it.

Create an infura account and a project, get the project ID.

The `hardhat.config.js` also needs it.


## Smart Contract

1. NFT.sol

location: /contracts/NFT.sol

 - Using openzeppelin for higher security
 - Mint new token 
 
 2. NFT.sol

location: /contracts/NFTMarket.sol

 - Can fetch all the market items
 - Can create market item
 - Can sell item user created or bought
 - Can fetch user's creations with address
 
 
## Development Env

1. hardhat

```
    npx hardhat node
```

run a local blockchain

2. Hardhat Config file 

Location: /hardhat.config.js

最初はTruffleを利用しましたが、今回は初めてhardhatを使ってみました
 
ローカルチェーンはChainIdを1377に設定しそのまま起動して使えますが、PolygonのテストネットMumbaiにはInfuraのProject（Project ID付きのURL）を使う必要があります。
 
3. Deploy
```
 npx hardhat run scripts/deploy.js --network mumbai/localhost
```

hardhat.config.jsにネットワーク記載、deployスクリプト実行
 
 4. Smart Contract Address
 
 Location: /config.js
 
 デプロイ後二つスマートコントラクトのアドレスがプリントされます。アドレスをconfig.jsファイルに記入します。フロントエンドFetchingの時に使う
 
 5. Json file(abi)
 
 Location: /artifacts/contracts/NFT.sol(NFTMarket.sol)/NFT.json(NFTMarket.json)
 
library `ethers` を利用時コンタクトパラメータとして使用しています 
 
 6. Test 
 
 Location: /test/sample-test.js
 
テストは最近書き始めたため、まだ未熟です。サンプルで一個だけ作ってdeployしました。


## Frontend


React

Location: /pages

機能説明：




Router:  _app.js

index.js -> `MarketPlaceのすべてItems`

create-items.js -> `アイテム情報を入力し、NFT作成`

creator-dashboard.js ->`作ったItemsと販売したItems`

my-assets.js -> `購入したItems`


## Server


GCP

 Demo Url: https://divesinto.com/
 
 
 Docker hub: 
 
 ```
 docker pull cxxxx/nft-marketplace
 ```
