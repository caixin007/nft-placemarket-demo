import "../styles/globals.css";
import Link from "next/link";
import Web3Modal from "web3modal";
import { useEffect, useState } from "react";
import { ethers } from "ethers";

function MyApp({ Component, pageProps }) {
  const [currentAdd, setCurrentAdd] = useState("");

  useEffect(() => {
    getAdress();
  }, []);

  async function getAdress() {
    const web3Modal = new Web3Modal();
    const connection = await web3Modal.connect();
    const provider = new ethers.providers.Web3Provider(connection);
    const signer = provider.getSigner();

    signer
      .getAddress()
      .then((add) => setCurrentAdd(add))
      .catch((err) => console.log(err));
  }

  return (
    <div>
      <nav className="border-b p-6">
        <p className="text-4xl font-bold">NFT Marketplace Demo</p>
        <div className="flex mt-4">
          <Link href="/">
            <a className="mr-4 text-blue-500">Home</a>
          </Link>
          <Link href="/creator-dashboard">
            <a className="mr-6 text-blue-500">Dashboard</a>
          </Link>
          <Link href="/create-item">
            <a className="mr-6 text-blue-500">Create NFT</a>
          </Link>
          <Link href="/my-assets">
            <a className="mr-6 text-blue-500">Purchased NFTs</a>
          </Link>
        </div>
        <div className="flex mt-4">Current Address: {currentAdd}</div>
      </nav>
      <Component {...pageProps} />
    </div>
  );
}

export default MyApp;
