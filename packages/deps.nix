{ fetchurl }: {
  libassuan = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libassuan-2.5.7.tar.bz2";
    sha256 = "0103081ffc27838a2e50479153ca105e873d3d65d8a9593282e9c94c7e6afb76";
  };
  xsltml = fetchurl {
    url = "https://dev-www.libreoffice.org/src/a7983f859eafb2677d7ff386a023bc40-xsltml_2.1.2.zip";
    sha256 = "75823776fb51a9c526af904f1503a7afaaab900fba83eda64f8a41073724c870";
  };
  bzip2 = fetchurl {
    url = "https://dev-www.libreoffice.org/src/bzip2-1.0.8.tar.gz";
    sha256 = "ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269";
  };
  mariadb-connector-c = fetchurl {
    url = "https://dev-www.libreoffice.org/src/mariadb-connector-c-3.3.8-src.tar.gz";
    sha256 = "f9f076b4aa9fb22cc94b24f82c80f9ef063805ecd6533a2eb5d5060cf93833e8";c
  };
  font-scheherazade = fetchurl {
    url = "https://dev-www.libreoffice.org/src/Scheherazade-2.100.zip";
    sha256 = "251c8817ceb87d9b661ce1d5b49e732a0116add10abc046be4b8ba5196e149b5";
  };
  boost = fetchurl {
    url = "https://dev-www.libreoffice.org/src/boost_1_84_0.tar.xz";
    sha256 = "fd4a2ee785ea0e4efc5221a4284e0cf51096e8409871fb70fdaced002eeffc0b";
  };
  ebook = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libe-book-0.1.3.tar.xz";
    sha256 = "7e8d8ff34f27831aca3bc6f9cc532c2f90d2057c778963b884ff3d1e34dfe1f9";
  };
  jfreereport-libloader = fetchurl {
    url = "https://dev-www.libreoffice.org/src/97b2d4dba862397f446b217e2b623e71-libloader-1.1.6.zip";
    sha256 = "3d853b19b1d94a6efa69e7af90f7f2b09ecf302913bee3da796c15ecfebcfac8";
  };
  poppler-data = fetchurl {
    url = "https://dev-www.libreoffice.org/src/poppler-data-0.4.12.tar.gz";
    sha256 = "c835b640a40ce357e1b83666aabd95edffa24ddddd49b8daff63adb851cdab74";
  };
  argon2 = fetchurl {
    url = "https://dev-www.libreoffice.org/src/phc-winner-argon2-20190702.tar.gz";
    sha256 = "daf972a89577f8772602bf2eb38b6a3dd3d922bf5724d45e7f9589b5e830442c";
  };
  libxslt = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libxslt-1.1.39.tar.xz";
    sha256 = "2a20ad621148339b0759c4d4e96719362dee64c9a096dbba625ba053846349f0";
  };
  font-noto-sans-arabic = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSansArabic-v2.010.zip";
    sha256 = "a5a34ac1ea01d0d71c083f99440ebfb1f64224474a0d88bb7ef0e2f8d9a996d2";
  };
  font-noto-serif-georgian = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSerifGeorgian-v2.003.zip";
    sha256 = "cfb41a264b97d463bab6807a5be937ba4a6ddcfa93d519a21b98b0ba73ca27d4";
  };
  clucene = fetchurl {
    url = "https://dev-www.libreoffice.org/src/48d647fbd8ef8889e5a7f422c1bfda94-clucene-core-2.3.3.4.tar.gz";
    sha256 = "ddfdc433dd8ad31b5c5819cc4404a8d2127472a3b720d3e744e8c51d79732eab";
  };
  font-libre-hebrew = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libre-hebrew-1.0.tar.gz";
    sha256 = "f596257c1db706ce35795b18d7f66a4db99d427725f20e9384914b534142579a";
  };
  font-reem = fetchurl {
    url = "https://dev-www.libreoffice.org/src/ReemKufi-1.7.zip";
    sha256 = "2359f036c7bddeb4d5529d7b3c9139c3288c920cc26053d417cdbb563eafe0a4";
  };
  font-noto-sans-georgian = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSansGeorgian-v2.005.zip";
    sha256 = "10e85011008108308e6feab0408242acb07804da61ede3d3ff236461ae07ab1b";
  };
  epoxy = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libepoxy-1.5.10.tar.gz";
    sha256 = "a7ced37f4102b745ac86d6a70a9da399cc139ff168ba6b8002b4d8d43c900c15";
  };
  font-gentium = fetchurl {
    url = "https://dev-www.libreoffice.org/src/1725634df4bb3dcb1b2c91a6175f8789-GentiumBasic_1102.zip";
    sha256 = "2f1a2c5491d7305dffd3520c6375d2f3e14931ee35c6d8ae1e8f098bf1a7b3cc";
  };
  jfreereport-libformula = fetchurl {
    url = "https://dev-www.libreoffice.org/src/3404ab6b1792ae5f16bbd603bd1e1d03-libformula-1.1.7.zip";
    sha256 = "5826d1551bf599b85742545f6e01a0079b93c1b2c8434bf409eddb3a29e4726b";
  };
  cdr = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libcdr-0.1.7.tar.xz";
    sha256 = "5666249d613466b9aa1e987ea4109c04365866e9277d80f6cd9663e86b8ecdd4";
  };
  openssl = fetchurl {
    url = "https://dev-www.libreoffice.org/src/openssl-3.0.13.tar.gz";
    sha256 = "88525753f79d3bec27d2fa7c66aa0b92b3aa9498dafd93d7cfa4b3780cdae313";
  };
  staroffice = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libstaroffice-0.0.7.tar.xz";
    sha256 = "f94fb0ad8216f97127bedef163a45886b43c62deac5e5b0f5e628e234220c8db";
  };
  hunspell = fetchurl {
    url = "https://dev-www.libreoffice.org/src/hunspell-1.7.2.tar.gz";
    sha256 = "11ddfa39afe28c28539fe65fc4f1592d410c1e9b6dd7d8a91ca25d85e9ec65b8";
  };
  curl = fetchurl {
    url = "https://dev-www.libreoffice.org/src/curl-8.7.1.tar.xz";
    sha256 = "6fea2aac6a4610fbd0400afb0bcddbe7258a64c63f1f68e5855ebc0c659710cd";
  };
  pagemaker = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libpagemaker-0.0.4.tar.xz";
    sha256 = "66adacd705a7d19895e08eac46d1e851332adf2e736c566bef1164e7a442519d";
  };
  onlineupdate = fetchurl {
    url = "https://dev-www.libreoffice.org/src/onlineupdate-c003be8b9727672e7d30972983b375f4c200233f-2.tar.xz";
    sha256 = "37206cf981e8409d048b59ac5839621ea107ff49af72beb9d7769a2f41da8d90";
  };
  fontconfig = fetchurl {
    url = "https://dev-www.libreoffice.org/src/fontconfig-2.15.0.tar.xz";
    sha256 = "63a0658d0e06e0fa886106452b58ef04f21f58202ea02a94c39de0d3335d7c0e";
  };
  font-liberation = fetchurl {
    url = "https://dev-www.libreoffice.org/src/liberation-fonts-ttf-2.1.5.tar.gz";
    sha256 = "7191c669bf38899f73a2094ed00f7b800553364f90e2637010a69c0e268f25d0";
  };
  firebird = fetchurl {
    url = "https://dev-www.libreoffice.org/src/Firebird-3.0.7.33374-0.tar.bz2";
    sha256 = "acb85cedafa10ce106b1823fb236b1b3e5d942a5741e8f8435cc8ccfec0afe76";
  };
  libjpeg-turbo = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libjpeg-turbo-2.1.5.1.tar.gz";
    sha256 = "2fdc3feb6e9deb17adec9bafa3321419aa19f8f4e5dea7bf8486844ca22207bf";
  };
  libnumbertext = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libnumbertext-1.0.11.tar.xz";
    sha256 = "5dcb4db3b2340f81f601ce86d8d76b69e34d70f84f804192c901e4b7f84d5fb0";
  };
  freetype = fetchurl {
    url = "https://dev-www.libreoffice.org/src/freetype-2.13.2.tar.xz";
    sha256 = "12991c4e55c506dd7f9b765933e62fd2be2e06d421505d7950a132e4f1bb484d";
  };
  mdds = fetchurl {
    url = "https://dev-www.libreoffice.org/src/mdds-2.1.1.tar.xz";
    sha256 = "1483d90cefb8aa4563c4d0a85cb7b243aa95217d235d422e9ca6722fd5b97e56";
  };
  libpng = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libpng-1.6.43.tar.xz";
    sha256 = "6a5ca0652392a2d7c9db2ae5b40210843c0bbc081cbd410825ab00cc59f14a6c";
  };
  epm = fetchurl {
    url = "https://dev-www.libreoffice.org/src/3ade8cfe7e59ca8e65052644fed9fca4-epm-3.7.tar.gz";
    sha256 = "b3fc4c5445de6c9a801504a3ea3efb2d4ea9d5a622c9427e716736e7713ddb91";
  };
  icu-data = fetchurl {
    url = "https://dev-www.libreoffice.org/src/icu4c-73_2-data.zip";
    sha256 = "ca1ee076163b438461e484421a7679fc33a64cd0a54f9d4b401893fa1eb42701";
  };
  libatomic-ops = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libatomic_ops-7.8.0.tar.gz";
    sha256 = "15676e7674e11bda5a7e50a73f4d9e7d60452271b8acf6fd39a71fefdf89fa31";
  };
  libxml = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libxml2-2.12.6.tar.xz";
    sha256 = "889c593a881a3db5fdd96cc9318c87df34eb648edfc458272ad46fd607353fbb";
  };
  libeot = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libeot-0.01.tar.bz2";
    sha256 = "cf5091fa8e7dcdbe667335eb90a2cfdd0a3fe8f8c7c8d1ece44d9d055736a06a";
  };
  frozen = fetchurl {
    url = "https://dev-www.libreoffice.org/src/frozen-1.1.1.tar.gz";
    sha256 = "f7c7075750e8fceeac081e9ef01944f221b36d9725beac8681cbd2838d26be45";
  };
  font-caladea = fetchurl {
    url = "https://dev-www.libreoffice.org/src/368f114c078f94214a308a74c7e991bc-crosextrafonts-20130214.tar.gz";
    sha256 = "c48d1c2fd613c9c06c959c34da7b8388059e2408d2bb19845dc3ed35f76e4d09";
  };
  postgresql = fetchurl {
    url = "https://dev-www.libreoffice.org/src/postgresql-13.14.tar.bz2";
    sha256 = "b8df078551898960bd500dc5d38a177e9905376df81fe7f2b660a1407fa6a5ed";
  };
  gpgme = fetchurl {
    url = "https://dev-www.libreoffice.org/src/gpgme-1.23.2.tar.bz2";
    sha256 = "9499e8b1f33cccb6815527a1bc16049d35a6198a6c5fae0185f2bd561bce5224";
  };
  dragonbox = fetchurl {
    url = "https://dev-www.libreoffice.org/src/dragonbox-1.1.3.tar.gz";
    sha256 = "09d63b05e9c594ec423778ab59b7a5aa1d76fdd71d25c7048b0258c4ec9c3384";
  };
  jfreereport-libxml = fetchurl {
    url = "https://dev-www.libreoffice.org/src/ace6ab49184e329db254e454a010f56d-libxml-1.1.7.zip";
    sha256 = "7d2797fe9f79a77009721e3f14fa4a1dec17a6d706bdc93f85f1f01d124fab66";
  };
  font-liberation-narrow = fetchurl {
    url = "https://dev-www.libreoffice.org/src/liberation-narrow-fonts-ttf-1.07.6.tar.gz";
    sha256 = "8879d89b5ff7b506c9fc28efc31a5c0b954bbe9333e66e5283d27d20a8519ea3";
  };
  visio = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libvisio-0.1.7.tar.xz";
    sha256 = "8faf8df870cb27b09a787a1959d6c646faa44d0d8ab151883df408b7166bea4c";
  };
  langtagreg = fetchurl {
    url = "https://dev-www.libreoffice.org/src/language-subtag-registry-2023-08-02.tar.bz2";
    sha256 = "59fdc026b5088e7947e1e6add482d2a40e1f7e25c50f198b456954216462c2eb";
  };
  font-noto-sans-armenian = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSansArmenian-v2.008.zip";
    sha256 = "eab89b99e134177ca6a3f9f0412a7cb812aafceb13175d686b4c45cb237f64ac";
  };
  wpd = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libwpd-0.10.3.tar.xz";
    sha256 = "2465b0b662fdc5d4e3bebcdc9a79027713fb629ca2bff04a3c9251fdec42dd09";
  };
  liblangtag = fetchurl {
    url = "https://dev-www.libreoffice.org/src/liblangtag-0.6.7.tar.bz2";
    sha256 = "5ed6bcd4ae3f3c05c912e62f216cd1a44123846147f729a49fb5668da51e030e";
  };
  font-alef = fetchurl {
    url = "https://dev-www.libreoffice.org/src/alef-1.001.tar.gz";
    sha256 = "b98b67602a2c8880a1770f0b9e37c190f29a7e2ade5616784f0b89fbdb75bf52";
  };
  abw = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libabw-0.1.3.tar.xz";
    sha256 = "e763a9dc21c3d2667402d66e202e3f8ef4db51b34b79ef41f56cacb86dcd6eed";
  };
  libtiff = fetchurl {
    url = "https://dev-www.libreoffice.org/src/tiff-4.6.0.tar.xz";
    sha256 = "e178649607d1e22b51cf361dd20a3753f244f022eefab1f2f218fc62ebaf87d2";
  };
  harfbuzz = fetchurl {
    url = "https://dev-www.libreoffice.org/src/harfbuzz-8.4.0.tar.xz";
    sha256 = "af4ea73e25ab748c8c063b78c2f88e48833db9b2ac369e29bd115702e789755e";
  };
  odfgen = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libodfgen-0.1.8.tar.xz";
    sha256 = "55200027fd46623b9bdddd38d275e7452d1b0ff8aeddcad6f9ae6dc25f610625";
  };
  font-culmus = fetchurl {
    url = "https://dev-www.libreoffice.org/src/culmus-0.133.tar.gz";
    sha256 = "c0c6873742d07544f6bacf2ad52eb9cb392974d56427938dc1dfbc8399c64d05";
  };
  etonyek = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libetonyek-0.1.10.tar.xz";
    sha256 = "b430435a6e8487888b761dc848b7981626eb814884963ffe25eb26a139301e9a";
  };
  python = fetchurl {
    url = "https://dev-www.libreoffice.org/src/Python-3.8.19.tar.xz";
    sha256 = "d2807ac69f69b84fd46a0b93bbd02a4fa48d3e70f4b2835ff0f72a2885040076";
  };
  twain-dsm = fetchurl {
    url = "https://dev-www.libreoffice.org/src/twaindsm_2.4.1.orig.tar.gz";
    sha256 = "82c818be771f242388457aa8c807e4b52aa84dc22b21c6c56184a6b4cbb085e6";
  };
  mspub = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libmspub-0.1.4.tar.xz";
    sha256 = "ef36c1a1aabb2ba3b0bedaaafe717bf4480be2ba8de6f3894be5fd3702b013ba";
  };
  box2d = fetchurl {
    url = "https://dev-www.libreoffice.org/src/box2d-2.4.1.tar.gz";
    sha256 = "d6b4650ff897ee1ead27cf77a5933ea197cbeef6705638dd181adc2e816b23c2";
  };
  dtoa = fetchurl {
    url = "https://dev-www.libreoffice.org/src/dtoa-20180411.tgz";
    sha256 = "0082d0684f7db6f62361b76c4b7faba19e0c7ce5cb8e36c4b65fea8281e711b4";
  };
  pixman = fetchurl {
    url = "https://dev-www.libreoffice.org/src/pixman-0.42.2.tar.gz";
    sha256 = "ea1480efada2fd948bc75366f7c349e1c96d3297d09a3fe62626e38e234a625e";
  };
  jfreereport-flow-engine = fetchurl {
    url = "https://dev-www.libreoffice.org/src/ba2930200c9f019c2d93a8c88c651a0f-flow-engine-0.9.4.zip";
    sha256 = "233f66e8d25c5dd971716d4200203a612a407649686ef3b52075d04b4c9df0dd";
  };
  lpsolve = fetchurl {
    url = "https://dev-www.libreoffice.org/src/26b3e95ddf3d9c077c480ea45874b3b8-lp_solve_5.5.tar.gz";
    sha256 = "171816288f14215c69e730f7a4f1c325739873e21f946ff83884b350574e6695";
  };
  rasqal = fetchurl {
    url = "https://dev-www.libreoffice.org/src/1f5def51ca0026cd192958ef07228b52-rasqal-0.9.33.tar.gz";
    sha256 = "6924c9ac6570bd241a9669f83b467c728a322470bf34f4b2da4f69492ccfd97c";
  };
  font-noto-sans-hebrew = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSansHebrew-v2.003.zip";
    sha256 = "ded809309ff924bc45834bf19afaa5693cadf17580972468f6041f5e599ddb8a";
  };
  font-noto-kufi-arabic = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoKufiArabic-v2.109.zip";
    sha256 = "1b6880e4b8df09c3b9e246d6084bfd94bf32a0ffff60cf2dcffd3622d0e2d79f";
  };
  zxcvbn-c = fetchurl {
    url = "https://dev-www.libreoffice.org/src/zxcvbn-c-2.5.tar.gz";
    sha256 = "77d6c6ecb35952a8d8ce7f736b7a2bf466275c48210e309b73782d6b7e84dffd";
  };
  cppunit = fetchurl {
    url = "https://dev-www.libreoffice.org/src/cppunit-1.15.1.tar.gz";
    sha256 = "89c5c6665337f56fd2db36bc3805a5619709d51fb136e51937072f63fcc717a7";
  };
  rhino = fetchurl {
    url = "https://dev-www.libreoffice.org/src/rhino-1.7.14.zip";
    sha256 = "bf4d2d0c5ff8889fd494486db09291cb7965f0bf2f93ef005d3b08070a5a4f5c";
  };
  redland = fetchurl {
    url = "https://dev-www.libreoffice.org/src/e5be03eda13ef68aabab6e42aa67715e-redland-1.0.17.tar.gz";
    sha256 = "de1847f7b59021c16bdc72abb4d8e2d9187cd6124d69156f3326dd34ee043681";
  };
  font-noto-sans-lao = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSansLao-v2.003.zip";
    sha256 = "5a87c31b1a40ef8147c1e84437e5f0ceba2d4dbbfc0b56a65821ad29870da8c0";
  };
  jfreereport-libfonts = fetchurl {
    url = "https://dev-www.libreoffice.org/src/3bdf40c0d199af31923e900d082ca2dd-libfonts-1.1.6.zip";
    sha256 = "e0531091787c0f16c83965fdcbc49162c059d7f0c64669e7f119699321549743";
  };
  font-noto-serif-armenian = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSerifArmenian-v2.008.zip";
    sha256 = "b21c198a4c76ae598a304decefb3b5c2a4c2d4c3ae226728eff359185f291c6f";
  };
  font-noto-serif-lao = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSerifLao-v2.003.zip";
    sha256 = "e96a303d3347790b0ef3db274971a989a736ce766ec9ea1bea0e1458568a80b2";
  };
  font-dejavu = fetchurl {
    url = "https://dev-www.libreoffice.org/src/33e1e61fab06a547851ed308b4ffef42-dejavu-fonts-ttf-2.37.zip";
    sha256 = "7576310b219e04159d35ff61dd4a4ec4cdba4f35c00e002a136f00e96a908b0a";
  };
  mwaw = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libmwaw-0.3.21.tar.xz";
    sha256 = "e8750123a78d61b943cef78b7736c8a7f20bb0a649aa112402124fba794fc21c";
  };
  icu = fetchurl {
    url = "https://dev-www.libreoffice.org/src/icu4c-73_2-src.tgz";
    sha256 = "818a80712ed3caacd9b652305e01afc7fa167e6f2e94996da44b90c2ab604ce1";
  };
  jfreereport-sac = fetchurl {
    url = "https://dev-www.libreoffice.org/src/39bb3fcea1514f1369fcfc87542390fd-sacjava-1.3.zip";
    sha256 = "085f2112c51fa8c1783fac12fbd452650596415121348393bb51f0f7e85a9045";
  };
  epubgen = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libepubgen-0.1.1.tar.xz";
    sha256 = "03e084b994cbeffc8c3dd13303b2cb805f44d8f2c3b79f7690d7e3fc7f6215ad";
  };
  jfreereport-libserializer = fetchurl {
    url = "https://dev-www.libreoffice.org/src/f94d9870737518e3b597f9265f4e9803-libserializer-1.1.6.zip";
    sha256 = "05640a1f6805b2b2d7e2cb9c50db9a5cb084e3c52ab1a71ce015239b4a1d4343";
  };
  font-noto-naskh-arabic = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoNaskhArabic-v2.018.zip";
    sha256 = "3c5dce5eebe2b8bd9e2d208872c5b6d51d1a2a99bd77528d4d72651a00b164f0";
  };
  mdnsresponder = fetchurl {
    url = "https://dev-www.libreoffice.org/src/mDNSResponder-878.200.35.tar.gz";
    sha256 = "e777b4d7dbf5eb1552cb80090ad1ede319067ab6e45e3990d68aabf6e8b3f5a0";
  };
  nss = fetchurl {
    url = "https://dev-www.libreoffice.org/src/nss-3.99-with-nspr-4.35.tar.gz";
    sha256 = "5f29fea64b3234b33a615b6df40469e239a4168ac0909106bd00e6490b274c31";
  };
  java-websocket = fetchurl {
    url = "https://dev-www.libreoffice.org/src/Java-WebSocket-1.5.4.tar.gz";
    sha256 = "a6828b35d1f938fee2335945f3d3c563cbbfa58ce7eb0bf72778d0fa7a550720";
  };
  zmf = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libzmf-0.0.2.tar.xz";
    sha256 = "27051a30cb057fdb5d5de65a1f165c7153dc76e27fe62251cbb86639eb2caf22";
  };
  xmlsec = fetchurl {
    url = "https://dev-www.libreoffice.org/src/xmlsec1-1.3.4.tar.gz";
    sha256 = "45ad9078d41ae76844ad2f8651600ffeec0fdd128ead988a8d69e907c57aee75";
  };
  mythes = fetchurl {
    url = "https://dev-www.libreoffice.org/src/mythes-1.2.5.tar.xz";
    sha256 = "19279f70707bbe5ffa619f2dc319f888cec0c4a8d339dc0a21330517bd6f521d";
  };
  orcus = fetchurl {
    url = "https://dev-www.libreoffice.org/src/liborcus-0.19.2.tar.xz";
    sha256 = "69ed26a00d4aaa7688e62a6e003cbc81928521a45e96605e53365aa499719e39";
  };
  font-noto-sans-lisu = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSansLisu-v2.102.zip";
    sha256 = "b12a1ff762680681b7ce4d98dd29a7f54d90f5bcadd10c955afc640a27b3a268";
  };
  qxp = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libqxp-0.0.2.tar.xz";
    sha256 = "e137b6b110120a52c98edd02ebdc4095ee08d0d5295a94316a981750095a945c";
  };
  font-amiri = fetchurl {
    url = "https://dev-www.libreoffice.org/src/Amiri-1.000.zip";
    sha256 = "926fe1bd7dfde8e55178281f645258bfced6420c951c6f2fd532fd21691bca30";
  };
  bsh = fetchurl {
    url = "https://dev-www.libreoffice.org/src/beeca87be45ec87d241ddd0e1bad80c1-bsh-2.0b6-src.zip";
    sha256 = "9e93c73e23aff644b17dfff656444474c14150e7f3b38b19635e622235e01c96";
  };
  lxml = fetchurl {
    url = "https://dev-www.libreoffice.org/src/lxml-4.9.2.tgz";
    sha256 = "2455cfaeb7ac70338b3257f41e21f0724f4b5b0c0e7702da67ee6c3640835b67";
  };
  jfreereport-liblayout = fetchurl {
    url = "https://dev-www.libreoffice.org/src/db60e4fde8dd6d6807523deb71ee34dc-liblayout-0.2.10.zip";
    sha256 = "e1fb87f3f7b980d33414473279615c4644027e013012d156efa538bc2b031772";
  };
  libgpgerror = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libgpg-error-1.48.tar.bz2";
    sha256 = "89ce1ae893e122924b858de84dc4f67aae29ffa610ebf668d5aa539045663d6f";
  };
  libtommath = fetchurl {
    url = "https://dev-www.libreoffice.org/src/ltm-1.3.0.tar.xz";
    sha256 = "296272d93435991308eb73607600c034b558807a07e829e751142e65ccfa9d08";
  };
  libexttextcat = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libexttextcat-3.4.7.tar.xz";
    sha256 = "df0a59d413a5b202573d8d4f5159e33a8538da4f8e8e60979facc64d6290cebd";
  };
  font-noto-serif-hebrew = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSerifHebrew-v2.003.zip";
    sha256 = "e45c149d6c29b38b8981401f875ab4304e73a366312783c41c082eb5366d3921";
  };
  skia = fetchurl {
    url = "https://dev-www.libreoffice.org/src/skia-m116-2ddcf183eb260f63698aa74d1bb380f247ad7ccd.tar.xz";
    sha256 = "2223ebce534458a37826e8fe4f24635b0712cde7ed1bd3208f089f6fdd796e01";
  };
  zlib = fetchurl {
    url = "https://dev-www.libreoffice.org/src/zlib-1.3.1.tar.xz";
    sha256 = "38ef96b8dfe510d42707d9c781877914792541133e1870841463bfa73f883e32";
  };
  glm = fetchurl {
    url = "https://dev-www.libreoffice.org/src/glm-0.9.9.8.zip";
    sha256 = "6bba5f032bed47c73ad9397f2313b9acbfb56253d0d0576b5873d3dcb25e99ad";
  };
  breakpad = fetchurl {
    url = "https://dev-www.libreoffice.org/src/breakpad-b324760c7f53667af128a6b77b790323da04fcb9.tar.xz";
    sha256 = "c44a2e898895cfc13b42d2371ba4b88b0777d7782214d6cdc91c33720f3b0d91";
  };
  libwebp = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libwebp-1.4.0.tar.gz";
    sha256 = "61f873ec69e3be1b99535634340d5bde750b2e4447caa1db9f61be3fd49ab1e5";
  };
  raptor = fetchurl {
    url = "https://dev-www.libreoffice.org/src/a39f6c07ddb20d7dd2ff1f95fa21e2cd-raptor2-2.0.15.tar.gz";
    sha256 = "ada7f0ba54787b33485d090d3d2680533520cd4426d2f7fb4782dd4a6a1480ed";
  };
  cairo = fetchurl {
    url = "https://dev-www.libreoffice.org/src/cairo-1.17.6.tar.xz";
    sha256 = "4eebc4c2bad0402bc3f501db184417094657d111fb6c06f076a82ea191fe1faf";
  };
  wps = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libwps-0.4.14.tar.xz";
    sha256 = "365b968e270e85a8469c6b160aa6af5619a4e6c995dbb04c1ecc1b4dd13e80de";
  };
  font-noto-sans = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSans-v2.013.zip";
    sha256 = "9fd595dd701d7ea103a9ba8a9cfdcf0c35c5574ef754fecabe718eadad8bccde";
  };
  zxing = fetchurl {
    url = "https://dev-www.libreoffice.org/src/zxing-cpp-2.2.1.tar.gz";
    sha256 = "02078ae15f19f9d423a441f205b1d1bee32349ddda7467e2c84e8f08876f8635";
  };
  poppler = fetchurl {
    url = "https://dev-www.libreoffice.org/src/poppler-24.03.0.tar.xz";
    sha256 = "bafbf0db5713dec25b5d16eb2cd87e4a62351cdc40f050c3937cd8dd6882d446";
  };
  font-linlibertineg = fetchurl {
    url = "https://dev-www.libreoffice.org/src/e7a384790b13c29113e22e596ade9687-LinLibertineG-20120116.zip";
    sha256 = "54adcb2bc8cac0927a647fbd9362f45eff48130ce6e2379dc3867643019e08c5";
  };
  jfreereport-libbase = fetchurl {
    url = "https://dev-www.libreoffice.org/src/eeb2c7ddf0d302fba4bfc6e97eac9624-libbase-1.1.6.zip";
    sha256 = "75c80359c9ce343c20aab8a36a45cb3b9ee7c61cf92c13ae45399d854423a9ba";
  };
  wpg = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libwpg-0.3.4.tar.xz";
    sha256 = "b55fda9440d1e070630eb2487d8b8697cf412c214a27caee9df69cec7c004de3";
  };
  font-noto-serif = fetchurl {
    url = "https://dev-www.libreoffice.org/src/NotoSerif-v2.013.zip";
    sha256 = "fb4c6c75f10365f63b5c8ad5a1864ebe46dd0c70c40d0461cb0dc1b1b7c13a35";
  };
  coinmp = fetchurl {
    url = "https://dev-www.libreoffice.org/src/CoinMP-1.8.4.tgz";
    sha256 = "3459fb0ccbdd39342744684338984ac4cc153fb0434f4cae8cf74bd67490a38d";
  };
  pdfium = fetchurl {
    url = "https://dev-www.libreoffice.org/src/pdfium-6425.tar.bz2";
    sha256 = "fe0291b96d7352bac530d13ef2e5fd63ad9980e0128911f88b957b5992508f1c";
  };
  libffi = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libffi-3.4.4.tar.gz";
    sha256 = "d66c56ad259a82cf2a9dfc408b32bf5da52371500b84745f7fb8b645712df676";
  };
  openldap = fetchurl {
    url = "https://dev-www.libreoffice.org/src/openldap-2.6.7.tgz";
    sha256 = "cd775f625c944ed78a3da18a03b03b08eea73c8aabc97b41bb336e9a10954930";
  };
  jfreereport-librepository = fetchurl {
    url = "https://dev-www.libreoffice.org/src/8ce2fcd72becf06c41f7201d15373ed9-librepository-1.1.6.zip";
    sha256 = "abe2c57ac12ba45d83563b02e240fa95d973376de2f720aab8fe11f2e621c095";
  };
  revenge = fetchurl {
    url = "https://dev-www.libreoffice.org/src/librevenge-0.0.4.tar.bz2";
    sha256 = "c51601cd08320b75702812c64aae0653409164da7825fd0f451ac2c5dbe77cbf";
  };
  jfreereport-flute = fetchurl {
    url = "https://dev-www.libreoffice.org/src/d8bd5eed178db6e2b18eeed243f85aa8-flute-1.1.6.zip";
    sha256 = "1b5b24f7bc543c0362b667692f78db8bab4ed6dafc6172f104d0bd3757d8a133";
  };
  lcms2 = fetchurl {
    url = "https://dev-www.libreoffice.org/src/lcms2-2.16.tar.gz";
    sha256 = "d873d34ad8b9b4cea010631f1a6228d2087475e4dc5e763eb81acc23d9d45a51";
  };
  expat = fetchurl {
    url = "https://dev-www.libreoffice.org/src/expat-2.6.2.tar.xz";
    sha256 = "ee14b4c5d8908b1bec37ad937607eab183d4d9806a08adee472c3c3121d27364";
  };
  iaccessible2 = fetchurl {
    url = "https://dev-www.libreoffice.org/src/IAccessible2-1.3+git20231013.3d8c7f0.tar.gz";
    sha256 = "0e279003f5199f80031c6dcd08f79d6f65a0505139160e7df0d09b226bff4023";
  };
  font-carlito = fetchurl {
    url = "https://dev-www.libreoffice.org/src/c74b7223abe75949b4af367942d96c7a-crosextrafonts-carlito-20130920.tar.gz";
    sha256 = "4bd12b6cbc321c1cf16da76e2c585c925ce956a08067ae6f6c64eff6ccfdaf5a";
  };
  libcmis = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libcmis-0.6.1.tar.xz";
    sha256 = "d54d19d86153dbc88e2d468f7136269a2cfe71b73227e12fded01d29ac268074";
  };
  graphite = fetchurl {
    url = "https://dev-www.libreoffice.org/src/graphite2-minimal-1.3.14.tgz";
    sha256 = "b8e892d8627c41888ff121e921455b9e2d26836978f2359173d19825da62b8fc";
  };
  hsqldb = fetchurl {
    url = "https://dev-www.libreoffice.org/src/17410483b5b5f267aa18b7e00b65e6e0-hsqldb_1_8_0.zip";
    sha256 = "d30b13f4ba2e3b6a2d4f020c0dee0a9fb9fc6fbcc2d561f36b78da4bf3802370";
  };
  hyphen = fetchurl {
    url = "https://dev-www.libreoffice.org/src/5ade6ae2a99bc1e9e57031ca88d36dad-hyphen-2.8.8.tar.gz";
    sha256 = "304636d4eccd81a14b6914d07b84c79ebb815288c76fe027b9ebff6ff24d5705";
  };
  freehand = fetchurl {
    url = "https://dev-www.libreoffice.org/src/libfreehand-0.1.2.tar.xz";
    sha256 = "0e422d1564a6dbf22a9af598535425271e583514c0f7ba7d9091676420de34ac";
  };
  opensymbol = fetchurl {
    url = "https://dev-www.libreoffice.org/extern/f543e6e2d7275557a839a164941c0a86e5f2c3f2a0042bfc434c88c6dde9e140-opens___.ttf";
    sha256 = "f543e6e2d7275557a839a164941c0a86e5f2c3f2a0042bfc434c88c6dde9e140";
  };
  odfvalidator = fetchurl {
    url = "https://dev-www.libreoffice.org/extern/odfvalidator-0.9.0-RC2-SNAPSHOT-jar-with-dependencies-2726ab578664434a545f8379a01a9faffac0ae73.jar";
    sha256 = "d55495ab3a86544650587de2a72180ddf8bfc6376d14ddfa923992dbc86a06e0";
  };
  officeotron = fetchurl {
    url = "https://dev-www.libreoffice.org/extern/8249374c274932a21846fa7629c2aa9b-officeotron-0.7.4-master.jar";
    sha256 = "f2443f27561af52324eee03a1892d9f569adc8db9e7bca55614898bc2a13a770";
  };
}
