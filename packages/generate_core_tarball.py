t = """# For the Flatpak build (which cannot execute `make fetch` from its---sandboxed---build
# environment), there is a solenv/flatpak-manifest.in that references these variables.
# There is a script solenv/bin/generate-flatpak-manifest.sh to substitute the variables,
# so upgrading to a new version only requires changes in download.lst.
ABW_SHA256SUM := e763a9dc21c3d2667402d66e202e3f8ef4db51b34b79ef41f56cacb86dcd6eed
ABW_TARBALL := libabw-0.1.3.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ARGON2_SHA256SUM := daf972a89577f8772602bf2eb38b6a3dd3d922bf5724d45e7f9589b5e830442c
ARGON2_TARBALL := phc-winner-argon2-20190702.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
# please repack the tarball using external/boost/repack_tarball.sh
BOOST_SHA256SUM := fd4a2ee785ea0e4efc5221a4284e0cf51096e8409871fb70fdaced002eeffc0b
BOOST_TARBALL := boost_1_84_0.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
BOX2D_SHA256SUM := d6b4650ff897ee1ead27cf77a5933ea197cbeef6705638dd181adc2e816b23c2
BOX2D_TARBALL := box2d-2.4.1.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
BREAKPAD_SHA256SUM := c44a2e898895cfc13b42d2371ba4b88b0777d7782214d6cdc91c33720f3b0d91
BREAKPAD_TARBALL := breakpad-b324760c7f53667af128a6b77b790323da04fcb9.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
BSH_SHA256SUM := 9e93c73e23aff644b17dfff656444474c14150e7f3b38b19635e622235e01c96
BSH_TARBALL := beeca87be45ec87d241ddd0e1bad80c1-bsh-2.0b6-src.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
BZIP2_SHA256SUM := ab5a03176ee106d3f0fa90e381da478ddae405918153cca248e682cd0c4a2269
BZIP2_TARBALL := bzip2-1.0.8.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
CAIRO_SHA256SUM := 4eebc4c2bad0402bc3f501db184417094657d111fb6c06f076a82ea191fe1faf
CAIRO_VERSION_MICRO := 6
CAIRO_TARBALL := cairo-1.17.$(CAIRO_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
CDR_SHA256SUM := 5666249d613466b9aa1e987ea4109c04365866e9277d80f6cd9663e86b8ecdd4
CDR_TARBALL := libcdr-0.1.7.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
CLUCENE_SHA256SUM := ddfdc433dd8ad31b5c5819cc4404a8d2127472a3b720d3e744e8c51d79732eab
CLUCENE_TARBALL := 48d647fbd8ef8889e5a7f422c1bfda94-clucene-core-2.3.3.4.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
DRAGONBOX_SHA256SUM := 09d63b05e9c594ec423778ab59b7a5aa1d76fdd71d25c7048b0258c4ec9c3384
DRAGONBOX_TARBALL := dragonbox-1.1.3.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
DTOA_SHA256SUM := 0082d0684f7db6f62361b76c4b7faba19e0c7ce5cb8e36c4b65fea8281e711b4
DTOA_TARBALL := dtoa-20180411.tgz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBCMIS_SHA256SUM := d54d19d86153dbc88e2d468f7136269a2cfe71b73227e12fded01d29ac268074
LIBCMIS_TARBALL := libcmis-0.6.1.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
COINMP_SHA256SUM := 3459fb0ccbdd39342744684338984ac4cc153fb0434f4cae8cf74bd67490a38d
COINMP_TARBALL := CoinMP-1.8.4.tgz
# three static lines
# so that git cherry-pick
# will not run into conflicts
CPPUNIT_SHA256SUM := 89c5c6665337f56fd2db36bc3805a5619709d51fb136e51937072f63fcc717a7
CPPUNIT_TARBALL := cppunit-1.15.1.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
CURL_SHA256SUM := 6fea2aac6a4610fbd0400afb0bcddbe7258a64c63f1f68e5855ebc0c659710cd
CURL_TARBALL := curl-8.7.1.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
EBOOK_SHA256SUM := 7e8d8ff34f27831aca3bc6f9cc532c2f90d2057c778963b884ff3d1e34dfe1f9
EBOOK_TARBALL := libe-book-0.1.3.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
EPOXY_SHA256SUM := a7ced37f4102b745ac86d6a70a9da399cc139ff168ba6b8002b4d8d43c900c15
EPOXY_TARBALL := libepoxy-1.5.10.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
EPM_SHA256SUM := b3fc4c5445de6c9a801504a3ea3efb2d4ea9d5a622c9427e716736e7713ddb91
EPM_TARBALL := 3ade8cfe7e59ca8e65052644fed9fca4-epm-3.7.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
EPUBGEN_SHA256SUM := 03e084b994cbeffc8c3dd13303b2cb805f44d8f2c3b79f7690d7e3fc7f6215ad
EPUBGEN_TARBALL := libepubgen-0.1.1.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ETONYEK_SHA256SUM := b430435a6e8487888b761dc848b7981626eb814884963ffe25eb26a139301e9a
ETONYEK_VERSION_MICRO := 10
ETONYEK_TARBALL := libetonyek-0.1.$(ETONYEK_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
EXPAT_SHA256SUM := ee14b4c5d8908b1bec37ad937607eab183d4d9806a08adee472c3c3121d27364
EXPAT_TARBALL := expat-2.6.2.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FIREBIRD_SHA256SUM := acb85cedafa10ce106b1823fb236b1b3e5d942a5741e8f8435cc8ccfec0afe76
FIREBIRD_TARBALL := Firebird-3.0.7.33374-0.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONTCONFIG_SHA256SUM := 63a0658d0e06e0fa886106452b58ef04f21f58202ea02a94c39de0d3335d7c0e
FONTCONFIG_TARBALL := fontconfig-2.15.0.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
# There are sadly now two Caladea fonts with different metrics, see:
#  https://bugzilla.redhat.com/show_bug.cgi?id=2162532
#  https://github.com/huertatipografica/Caladea/issues/4
# be careful on potential upgrades
FONT_CALADEA_SHA256SUM := c48d1c2fd613c9c06c959c34da7b8388059e2408d2bb19845dc3ed35f76e4d09
FONT_CALADEA_TARBALL := 368f114c078f94214a308a74c7e991bc-crosextrafonts-20130214.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_CARLITO_SHA256SUM := 4bd12b6cbc321c1cf16da76e2c585c925ce956a08067ae6f6c64eff6ccfdaf5a
FONT_CARLITO_TARBALL := c74b7223abe75949b4af367942d96c7a-crosextrafonts-carlito-20130920.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_DEJAVU_SHA256SUM := 7576310b219e04159d35ff61dd4a4ec4cdba4f35c00e002a136f00e96a908b0a
FONT_DEJAVU_TARBALL := 33e1e61fab06a547851ed308b4ffef42-dejavu-fonts-ttf-2.37.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_GENTIUM_SHA256SUM := 2f1a2c5491d7305dffd3520c6375d2f3e14931ee35c6d8ae1e8f098bf1a7b3cc
FONT_GENTIUM_TARBALL := 1725634df4bb3dcb1b2c91a6175f8789-GentiumBasic_1102.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_LIBERATION_NARROW_SHA256SUM := 8879d89b5ff7b506c9fc28efc31a5c0b954bbe9333e66e5283d27d20a8519ea3
FONT_LIBERATION_NARROW_TARBALL := liberation-narrow-fonts-ttf-1.07.6.tar.gz
FONT_LIBERATION_SHA256SUM := 7191c669bf38899f73a2094ed00f7b800553364f90e2637010a69c0e268f25d0
FONT_LIBERATION_TARBALL := liberation-fonts-ttf-2.1.5.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_LINLIBERTINEG_SHA256SUM := 54adcb2bc8cac0927a647fbd9362f45eff48130ce6e2379dc3867643019e08c5
FONT_LINLIBERTINEG_TARBALL := e7a384790b13c29113e22e596ade9687-LinLibertineG-20120116.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_KUFI_ARABIC_SHA256SUM := 1b6880e4b8df09c3b9e246d6084bfd94bf32a0ffff60cf2dcffd3622d0e2d79f
FONT_NOTO_KUFI_ARABIC_TARBALL := NotoKufiArabic-v2.109.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SANS_SHA256SUM := 9fd595dd701d7ea103a9ba8a9cfdcf0c35c5574ef754fecabe718eadad8bccde
FONT_NOTO_SANS_TARBALL := NotoSans-v2.013.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SERIF_SHA256SUM := fb4c6c75f10365f63b5c8ad5a1864ebe46dd0c70c40d0461cb0dc1b1b7c13a35
FONT_NOTO_SERIF_TARBALL := NotoSerif-v2.013.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SERIF_HEBREW_SHA256SUM := e45c149d6c29b38b8981401f875ab4304e73a366312783c41c082eb5366d3921
FONT_NOTO_SERIF_HEBREW_TARBALL := NotoSerifHebrew-v2.003.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SANS_ARABIC_SHA256SUM := a5a34ac1ea01d0d71c083f99440ebfb1f64224474a0d88bb7ef0e2f8d9a996d2
FONT_NOTO_SANS_ARABIC_TARBALL := NotoSansArabic-v2.010.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_NASKH_ARABIC_SHA256SUM := 3c5dce5eebe2b8bd9e2d208872c5b6d51d1a2a99bd77528d4d72651a00b164f0
FONT_NOTO_NASKH_ARABIC_TARBALL := NotoNaskhArabic-v2.018.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SANS_HEBREW_SHA256SUM := ded809309ff924bc45834bf19afaa5693cadf17580972468f6041f5e599ddb8a
FONT_NOTO_SANS_HEBREW_TARBALL := NotoSansHebrew-v2.003.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SANS_ARMENIAN_SHA256SUM := eab89b99e134177ca6a3f9f0412a7cb812aafceb13175d686b4c45cb237f64ac
FONT_NOTO_SANS_ARMENIAN_TARBALL := NotoSansArmenian-v2.008.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SERIF_ARMENIAN_SHA256SUM := b21c198a4c76ae598a304decefb3b5c2a4c2d4c3ae226728eff359185f291c6f
FONT_NOTO_SERIF_ARMENIAN_TARBALL := NotoSerifArmenian-v2.008.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SANS_GEORGIAN_SHA256SUM := 10e85011008108308e6feab0408242acb07804da61ede3d3ff236461ae07ab1b
FONT_NOTO_SANS_GEORGIAN_TARBALL := NotoSansGeorgian-v2.005.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SERIF_GEORGIAN_SHA256SUM := cfb41a264b97d463bab6807a5be937ba4a6ddcfa93d519a21b98b0ba73ca27d4
FONT_NOTO_SERIF_GEORGIAN_TARBALL := NotoSerifGeorgian-v2.003.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SANS_LAO_SHA256SUM := 5a87c31b1a40ef8147c1e84437e5f0ceba2d4dbbfc0b56a65821ad29870da8c0
FONT_NOTO_SANS_LAO_TARBALL := NotoSansLao-v2.003.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SERIF_LAO_SHA256SUM := e96a303d3347790b0ef3db274971a989a736ce766ec9ea1bea0e1458568a80b2
FONT_NOTO_SERIF_LAO_TARBALL := NotoSerifLao-v2.003.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_NOTO_SANS_LISU_SHA256SUM := b12a1ff762680681b7ce4d98dd29a7f54d90f5bcadd10c955afc640a27b3a268
FONT_NOTO_SANS_LISU_TARBALL := NotoSansLisu-v2.102.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_CULMUS_SHA256SUM := c0c6873742d07544f6bacf2ad52eb9cb392974d56427938dc1dfbc8399c64d05
FONT_CULMUS_TARBALL := culmus-0.133.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_LIBRE_HEBREW_SHA256SUM := f596257c1db706ce35795b18d7f66a4db99d427725f20e9384914b534142579a
FONT_LIBRE_HEBREW_TARBALL := libre-hebrew-1.0.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_ALEF_SHA256SUM := b98b67602a2c8880a1770f0b9e37c190f29a7e2ade5616784f0b89fbdb75bf52
FONT_ALEF_TARBALL := alef-1.001.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_AMIRI_SHA256SUM := 926fe1bd7dfde8e55178281f645258bfced6420c951c6f2fd532fd21691bca30
FONT_AMIRI_TARBALL := Amiri-1.000.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_REEM_SHA256SUM := 2359f036c7bddeb4d5529d7b3c9139c3288c920cc26053d417cdbb563eafe0a4
FONT_REEM_TARBALL := ReemKufi-1.7.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FONT_SCHEHERAZADE_SHA256SUM := 251c8817ceb87d9b661ce1d5b49e732a0116add10abc046be4b8ba5196e149b5
FONT_SCHEHERAZADE_TARBALL := Scheherazade-2.100.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
FREEHAND_SHA256SUM := 0e422d1564a6dbf22a9af598535425271e583514c0f7ba7d9091676420de34ac
FREEHAND_TARBALL := libfreehand-0.1.2.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FREETYPE_SHA256SUM := 12991c4e55c506dd7f9b765933e62fd2be2e06d421505d7950a132e4f1bb484d
FREETYPE_TARBALL := freetype-2.13.2.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
FROZEN_SHA256SUM := f7c7075750e8fceeac081e9ef01944f221b36d9725beac8681cbd2838d26be45
FROZEN_TARBALL := frozen-1.1.1.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
GLM_SHA256SUM := 6bba5f032bed47c73ad9397f2313b9acbfb56253d0d0576b5873d3dcb25e99ad
GLM_TARBALL := glm-0.9.9.8.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
GPGME_SHA256SUM := 9499e8b1f33cccb6815527a1bc16049d35a6198a6c5fae0185f2bd561bce5224
GPGME_TARBALL := gpgme-1.23.2.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
GRAPHITE_SHA256SUM := b8e892d8627c41888ff121e921455b9e2d26836978f2359173d19825da62b8fc
GRAPHITE_TARBALL := graphite2-minimal-1.3.14.tgz
# three static lines
# so that git cherry-pick
# will not run into conflicts
HARFBUZZ_SHA256SUM := af4ea73e25ab748c8c063b78c2f88e48833db9b2ac369e29bd115702e789755e
HARFBUZZ_TARBALL := harfbuzz-8.4.0.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
HSQLDB_SHA256SUM := d30b13f4ba2e3b6a2d4f020c0dee0a9fb9fc6fbcc2d561f36b78da4bf3802370
HSQLDB_TARBALL := 17410483b5b5f267aa18b7e00b65e6e0-hsqldb_1_8_0.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
HUNSPELL_SHA256SUM := 11ddfa39afe28c28539fe65fc4f1592d410c1e9b6dd7d8a91ca25d85e9ec65b8
HUNSPELL_TARBALL := hunspell-1.7.2.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
HYPHEN_SHA256SUM := 304636d4eccd81a14b6914d07b84c79ebb815288c76fe027b9ebff6ff24d5705
HYPHEN_TARBALL := 5ade6ae2a99bc1e9e57031ca88d36dad-hyphen-2.8.8.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
IACCESSIBLE2_SHA256SUM := 0e279003f5199f80031c6dcd08f79d6f65a0505139160e7df0d09b226bff4023
IACCESSIBLE2_TARBALL := IAccessible2-1.3+git20231013.3d8c7f0.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ICU_SHA256SUM := 818a80712ed3caacd9b652305e01afc7fa167e6f2e94996da44b90c2ab604ce1
ICU_TARBALL := icu4c-73_2-src.tgz
ICU_DATA_SHA256SUM := ca1ee076163b438461e484421a7679fc33a64cd0a54f9d4b401893fa1eb42701
ICU_DATA_TARBALL := icu4c-73_2-data.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
JAVA_WEBSOCKET_SHA256SUM := a6828b35d1f938fee2335945f3d3c563cbbfa58ce7eb0bf72778d0fa7a550720
JAVA_WEBSOCKET_TARBALL := Java-WebSocket-1.5.4.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
JFREEREPORT_FLOW_ENGINE_SHA256SUM := 233f66e8d25c5dd971716d4200203a612a407649686ef3b52075d04b4c9df0dd
JFREEREPORT_FLOW_ENGINE_TARBALL := ba2930200c9f019c2d93a8c88c651a0f-flow-engine-0.9.4.zip
JFREEREPORT_FLUTE_SHA256SUM := 1b5b24f7bc543c0362b667692f78db8bab4ed6dafc6172f104d0bd3757d8a133
JFREEREPORT_FLUTE_TARBALL := d8bd5eed178db6e2b18eeed243f85aa8-flute-1.1.6.zip
JFREEREPORT_LIBBASE_SHA256SUM := 75c80359c9ce343c20aab8a36a45cb3b9ee7c61cf92c13ae45399d854423a9ba
JFREEREPORT_LIBBASE_TARBALL := eeb2c7ddf0d302fba4bfc6e97eac9624-libbase-1.1.6.zip
JFREEREPORT_LIBFONTS_SHA256SUM := e0531091787c0f16c83965fdcbc49162c059d7f0c64669e7f119699321549743
JFREEREPORT_LIBFONTS_TARBALL := 3bdf40c0d199af31923e900d082ca2dd-libfonts-1.1.6.zip
JFREEREPORT_LIBFORMULA_SHA256SUM := 5826d1551bf599b85742545f6e01a0079b93c1b2c8434bf409eddb3a29e4726b
JFREEREPORT_LIBFORMULA_TARBALL := 3404ab6b1792ae5f16bbd603bd1e1d03-libformula-1.1.7.zip
JFREEREPORT_LIBLAYOUT_SHA256SUM := e1fb87f3f7b980d33414473279615c4644027e013012d156efa538bc2b031772
JFREEREPORT_LIBLAYOUT_TARBALL := db60e4fde8dd6d6807523deb71ee34dc-liblayout-0.2.10.zip
JFREEREPORT_LIBLOADER_SHA256SUM := 3d853b19b1d94a6efa69e7af90f7f2b09ecf302913bee3da796c15ecfebcfac8
JFREEREPORT_LIBLOADER_TARBALL := 97b2d4dba862397f446b217e2b623e71-libloader-1.1.6.zip
JFREEREPORT_LIBREPOSITORY_SHA256SUM := abe2c57ac12ba45d83563b02e240fa95d973376de2f720aab8fe11f2e621c095
JFREEREPORT_LIBREPOSITORY_TARBALL := 8ce2fcd72becf06c41f7201d15373ed9-librepository-1.1.6.zip
JFREEREPORT_LIBSERIALIZER_SHA256SUM := 05640a1f6805b2b2d7e2cb9c50db9a5cb084e3c52ab1a71ce015239b4a1d4343
JFREEREPORT_LIBSERIALIZER_TARBALL := f94d9870737518e3b597f9265f4e9803-libserializer-1.1.6.zip
JFREEREPORT_LIBXML_SHA256SUM := 7d2797fe9f79a77009721e3f14fa4a1dec17a6d706bdc93f85f1f01d124fab66
JFREEREPORT_LIBXML_TARBALL := ace6ab49184e329db254e454a010f56d-libxml-1.1.7.zip
JFREEREPORT_SAC_SHA256SUM := 085f2112c51fa8c1783fac12fbd452650596415121348393bb51f0f7e85a9045
JFREEREPORT_SAC_TARBALL := 39bb3fcea1514f1369fcfc87542390fd-sacjava-1.3.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBJPEG_TURBO_SHA256SUM := 2fdc3feb6e9deb17adec9bafa3321419aa19f8f4e5dea7bf8486844ca22207bf
LIBJPEG_TURBO_TARBALL := libjpeg-turbo-2.1.5.1.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LANGTAGREG_SHA256SUM := 59fdc026b5088e7947e1e6add482d2a40e1f7e25c50f198b456954216462c2eb
LANGTAGREG_TARBALL := language-subtag-registry-2023-08-02.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
LCMS2_SHA256SUM := d873d34ad8b9b4cea010631f1a6228d2087475e4dc5e763eb81acc23d9d45a51
LCMS2_TARBALL := lcms2-2.16.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBASSUAN_SHA256SUM := 0103081ffc27838a2e50479153ca105e873d3d65d8a9593282e9c94c7e6afb76
LIBASSUAN_TARBALL := libassuan-2.5.7.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBATOMIC_OPS_SHA256SUM := 15676e7674e11bda5a7e50a73f4d9e7d60452271b8acf6fd39a71fefdf89fa31
LIBATOMIC_OPS_TARBALL := libatomic_ops-7.8.0.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBEOT_SHA256SUM := cf5091fa8e7dcdbe667335eb90a2cfdd0a3fe8f8c7c8d1ece44d9d055736a06a
LIBEOT_TARBALL := libeot-0.01.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBEXTTEXTCAT_SHA256SUM := df0a59d413a5b202573d8d4f5159e33a8538da4f8e8e60979facc64d6290cebd
LIBEXTTEXTCAT_TARBALL := libexttextcat-3.4.7.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBFFI_SHA256SUM := d66c56ad259a82cf2a9dfc408b32bf5da52371500b84745f7fb8b645712df676
LIBFFI_TARBALL := libffi-3.4.4.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBGPGERROR_SHA256SUM := 89ce1ae893e122924b858de84dc4f67aae29ffa610ebf668d5aa539045663d6f
LIBGPGERROR_TARBALL := libgpg-error-1.48.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBLANGTAG_SHA256SUM := 5ed6bcd4ae3f3c05c912e62f216cd1a44123846147f729a49fb5668da51e030e
LIBLANGTAG_TARBALL := liblangtag-0.6.7.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBNUMBERTEXT_SHA256SUM := 5dcb4db3b2340f81f601ce86d8d76b69e34d70f84f804192c901e4b7f84d5fb0
LIBNUMBERTEXT_TARBALL := libnumbertext-1.0.11.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBTOMMATH_SHA256SUM := 296272d93435991308eb73607600c034b558807a07e829e751142e65ccfa9d08
LIBTOMMATH_TARBALL := ltm-1.3.0.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBWEBP_SHA256SUM := 61f873ec69e3be1b99535634340d5bde750b2e4447caa1db9f61be3fd49ab1e5
LIBWEBP_TARBALL := libwebp-1.4.0.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
XMLSEC_SHA256SUM := 45ad9078d41ae76844ad2f8651600ffeec0fdd128ead988a8d69e907c57aee75
XMLSEC_TARBALL := xmlsec1-1.3.4.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBXML_SHA256SUM := 889c593a881a3db5fdd96cc9318c87df34eb648edfc458272ad46fd607353fbb
LIBXML_VERSION_MICRO := 6
LIBXML_TARBALL := libxml2-2.12.$(LIBXML_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBXSLT_SHA256SUM := 2a20ad621148339b0759c4d4e96719362dee64c9a096dbba625ba053846349f0
LIBXSLT_VERSION_MICRO := 39
LIBXSLT_TARBALL := libxslt-1.1.$(LIBXSLT_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LPSOLVE_SHA256SUM := 171816288f14215c69e730f7a4f1c325739873e21f946ff83884b350574e6695
LPSOLVE_TARBALL := 26b3e95ddf3d9c077c480ea45874b3b8-lp_solve_5.5.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LXML_SHA256SUM := 2455cfaeb7ac70338b3257f41e21f0724f4b5b0c0e7702da67ee6c3640835b67
LXML_TARBALL := lxml-4.9.2.tgz
# three static lines
# so that git cherry-pick
# will not run into conflicts
MARIADB_CONNECTOR_C_SHA256SUM := f9f076b4aa9fb22cc94b24f82c80f9ef063805ecd6533a2eb5d5060cf93833e8
MARIADB_CONNECTOR_C_TARBALL := mariadb-connector-c-3.3.8-src.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
MDDS_SHA256SUM := 1483d90cefb8aa4563c4d0a85cb7b243aa95217d235d422e9ca6722fd5b97e56
MDDS_TARBALL := mdds-2.1.1.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
MDNSRESPONDER_SHA256SUM := e777b4d7dbf5eb1552cb80090ad1ede319067ab6e45e3990d68aabf6e8b3f5a0
MDNSRESPONDER_TARBALL := mDNSResponder-878.200.35.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
MSPUB_SHA256SUM := ef36c1a1aabb2ba3b0bedaaafe717bf4480be2ba8de6f3894be5fd3702b013ba
MSPUB_TARBALL := libmspub-0.1.4.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
MWAW_SHA256SUM := e8750123a78d61b943cef78b7736c8a7f20bb0a649aa112402124fba794fc21c
MWAW_VERSION_MICRO := 21
MWAW_TARBALL := libmwaw-0.3.$(MWAW_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
MYTHES_SHA256SUM := 19279f70707bbe5ffa619f2dc319f888cec0c4a8d339dc0a21330517bd6f521d
MYTHES_TARBALL := mythes-1.2.5.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
NSS_SHA256SUM := 5f29fea64b3234b33a615b6df40469e239a4168ac0909106bd00e6490b274c31
NSS_TARBALL := nss-3.99-with-nspr-4.35.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ODFGEN_SHA256SUM := 55200027fd46623b9bdddd38d275e7452d1b0ff8aeddcad6f9ae6dc25f610625
ODFGEN_VERSION_MICRO := 8
ODFGEN_TARBALL := libodfgen-0.1.$(ODFGEN_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ODFVALIDATOR_SHA256SUM := d55495ab3a86544650587de2a72180ddf8bfc6376d14ddfa923992dbc86a06e0
ODFVALIDATOR_JAR := odfvalidator-0.9.0-RC2-SNAPSHOT-jar-with-dependencies-2726ab578664434a545f8379a01a9faffac0ae73.jar
# three static lines
# so that git cherry-pick
# will not run into conflicts
OFFICEOTRON_SHA256SUM := f2443f27561af52324eee03a1892d9f569adc8db9e7bca55614898bc2a13a770
OFFICEOTRON_JAR := 8249374c274932a21846fa7629c2aa9b-officeotron-0.7.4-master.jar
# three static lines
# so that git cherry-pick
# will not run into conflicts
ONLINEUPDATE_SHA256SUM := 37206cf981e8409d048b59ac5839621ea107ff49af72beb9d7769a2f41da8d90
ONLINEUPDATE_TARBALL := onlineupdate-c003be8b9727672e7d30972983b375f4c200233f-2.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
OPENLDAP_SHA256SUM := cd775f625c944ed78a3da18a03b03b08eea73c8aabc97b41bb336e9a10954930
OPENLDAP_TARBALL := openldap-2.6.7.tgz
# three static lines
# so that git cherry-pick
# will not run into conflicts
OPENSSL_SHA256SUM := 88525753f79d3bec27d2fa7c66aa0b92b3aa9498dafd93d7cfa4b3780cdae313
OPENSSL_TARBALL := openssl-3.0.13.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ORCUS_SHA256SUM := 69ed26a00d4aaa7688e62a6e003cbc81928521a45e96605e53365aa499719e39
ORCUS_TARBALL := liborcus-0.19.2.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
PAGEMAKER_SHA256SUM := 66adacd705a7d19895e08eac46d1e851332adf2e736c566bef1164e7a442519d
PAGEMAKER_TARBALL := libpagemaker-0.0.4.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
PDFIUM_SHA256SUM := fe0291b96d7352bac530d13ef2e5fd63ad9980e0128911f88b957b5992508f1c
PDFIUM_TARBALL := pdfium-6425.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
PIXMAN_SHA256SUM := ea1480efada2fd948bc75366f7c349e1c96d3297d09a3fe62626e38e234a625e
PIXMAN_TARBALL := pixman-0.42.2.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBPNG_SHA256SUM := 6a5ca0652392a2d7c9db2ae5b40210843c0bbc081cbd410825ab00cc59f14a6c
LIBPNG_TARBALL := libpng-1.6.43.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
LIBTIFF_SHA256SUM := e178649607d1e22b51cf361dd20a3753f244f022eefab1f2f218fc62ebaf87d2
LIBTIFF_TARBALL := tiff-4.6.0.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
POPPLER_SHA256SUM := bafbf0db5713dec25b5d16eb2cd87e4a62351cdc40f050c3937cd8dd6882d446
POPPLER_TARBALL := poppler-24.03.0.tar.xz
POPPLER_DATA_SHA256SUM := c835b640a40ce357e1b83666aabd95edffa24ddddd49b8daff63adb851cdab74
POPPLER_DATA_TARBALL := poppler-data-0.4.12.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
POSTGRESQL_SHA256SUM := b8df078551898960bd500dc5d38a177e9905376df81fe7f2b660a1407fa6a5ed
POSTGRESQL_TARBALL := postgresql-13.14.tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
PYTHON_SHA256SUM := d2807ac69f69b84fd46a0b93bbd02a4fa48d3e70f4b2835ff0f72a2885040076
PYTHON_TARBALL := Python-3.8.19.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
QXP_SHA256SUM := e137b6b110120a52c98edd02ebdc4095ee08d0d5295a94316a981750095a945c
QXP_TARBALL := libqxp-0.0.2.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
RAPTOR_SHA256SUM := ada7f0ba54787b33485d090d3d2680533520cd4426d2f7fb4782dd4a6a1480ed
RAPTOR_TARBALL := a39f6c07ddb20d7dd2ff1f95fa21e2cd-raptor2-2.0.15.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
RASQAL_SHA256SUM := 6924c9ac6570bd241a9669f83b467c728a322470bf34f4b2da4f69492ccfd97c
RASQAL_TARBALL := 1f5def51ca0026cd192958ef07228b52-rasqal-0.9.33.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
REDLAND_SHA256SUM := de1847f7b59021c16bdc72abb4d8e2d9187cd6124d69156f3326dd34ee043681
REDLAND_TARBALL := e5be03eda13ef68aabab6e42aa67715e-redland-1.0.17.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
REVENGE_SHA256SUM := c51601cd08320b75702812c64aae0653409164da7825fd0f451ac2c5dbe77cbf
REVENGE_VERSION_MICRO := 4
REVENGE_TARBALL := librevenge-0.0.$(REVENGE_VERSION_MICRO).tar.bz2
# three static lines
# so that git cherry-pick
# will not run into conflicts
RHINO_SHA256SUM := bf4d2d0c5ff8889fd494486db09291cb7965f0bf2f93ef005d3b08070a5a4f5c
RHINO_TARBALL := rhino-1.7.14.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
SKIA_SHA256SUM := 2223ebce534458a37826e8fe4f24635b0712cde7ed1bd3208f089f6fdd796e01
SKIA_TARBALL := skia-m116-2ddcf183eb260f63698aa74d1bb380f247ad7ccd.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
STAROFFICE_SHA256SUM := f94fb0ad8216f97127bedef163a45886b43c62deac5e5b0f5e628e234220c8db
STAROFFICE_VERSION_MICRO := 7
STAROFFICE_TARBALL := libstaroffice-0.0.$(STAROFFICE_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
TWAIN_DSM_SHA256SUM := 82c818be771f242388457aa8c807e4b52aa84dc22b21c6c56184a6b4cbb085e6
TWAIN_DSM_TARBALL := twaindsm_2.4.1.orig.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
VISIO_SHA256SUM := 8faf8df870cb27b09a787a1959d6c646faa44d0d8ab151883df408b7166bea4c
VISIO_TARBALL := libvisio-0.1.7.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
WPD_SHA256SUM := 2465b0b662fdc5d4e3bebcdc9a79027713fb629ca2bff04a3c9251fdec42dd09
WPD_VERSION_MICRO := 3
WPD_TARBALL := libwpd-0.10.$(WPD_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
WPG_SHA256SUM := b55fda9440d1e070630eb2487d8b8697cf412c214a27caee9df69cec7c004de3
WPG_VERSION_MICRO := 4
WPG_TARBALL := libwpg-0.3.$(WPG_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
WPS_SHA256SUM := 365b968e270e85a8469c6b160aa6af5619a4e6c995dbb04c1ecc1b4dd13e80de
WPS_VERSION_MICRO := 14
WPS_TARBALL := libwps-0.4.$(WPS_VERSION_MICRO).tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
XSLTML_SHA256SUM := 75823776fb51a9c526af904f1503a7afaaab900fba83eda64f8a41073724c870
XSLTML_TARBALL := a7983f859eafb2677d7ff386a023bc40-xsltml_2.1.2.zip
# three static lines
# so that git cherry-pick
# will not run into conflicts
ZLIB_SHA256SUM := 38ef96b8dfe510d42707d9c781877914792541133e1870841463bfa73f883e32
ZLIB_TARBALL := zlib-1.3.1.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ZMF_SHA256SUM := 27051a30cb057fdb5d5de65a1f165c7153dc76e27fe62251cbb86639eb2caf22
ZMF_TARBALL := libzmf-0.0.2.tar.xz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ZXCVBN_C_SHA256SUM := 77d6c6ecb35952a8d8ce7f736b7a2bf466275c48210e309b73782d6b7e84dffd
ZXCVBN_C_TARBALL := zxcvbn-c-2.5.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
ZXING_SHA256SUM := 02078ae15f19f9d423a441f205b1d1bee32349ddda7467e2c84e8f08876f8635
ZXING_TARBALL := zxing-cpp-2.2.1.tar.gz
# three static lines
# so that git cherry-pick
# will not run into conflicts
NUMBERTEXT_EXTENSION_SHA256SUM := 1568ed1d2feb8210bb5de61d69574a165cded536cfa17c6953c9064076469de2
# three static lines
# so that git cherry-pick
# will not run into conflicts
OPENSYMBOL_SHA256SUM := f543e6e2d7275557a839a164941c0a86e5f2c3f2a0042bfc434c88c6dde9e140
OPENSYMBOL_TTF := f543e6e2d7275557a839a164941c0a86e5f2c3f2a0042bfc434c88c6dde9e140-opens___.ttf"""

from re import findall, sub
from subprocess import PIPE, Popen

t = sub(r"([\w_]+) := ", r"export \1=", t)
t = sub(r"\$\(([\w_]+)\)", r"$\1", t)
t += "\nenv"

p = Popen(["bash", "-c", t], stdout=PIPE)
stdout_bytes, _stderr_bytes = p.communicate()
stdout = stdout_bytes.decode()

env_mapping: dict[str, str] = {
    name: tar for name, tar in findall(r"([\w\d]+)=(.+)", stdout)
}

tarballs = [name[:-8] for name in env_mapping if name.endswith("_TARBALL")]

second_url_excludes = ["OPENSYMBOL", "ODFVALIDATOR", "OFFICEOTRON"]

print("{ fetchurl }: {")
for tarball_name in tarballs:
    tarball_filename = env_mapping[f"{tarball_name}_TARBALL"]
    tarball_hash = env_mapping[f"{tarball_name}_SHA256SUM"]
    print(
        """%(tarball_name)s = fetchurl {
  url = "https://dev-www.libreoffice.org/src/%(tarball_filename)s";
  sha256 = "%(sha256)s";
};"""
        % {
            "tarball_name": tarball_name.lower().replace("_", "-"),
            "tarball_filename": tarball_filename,
            "sha256": tarball_hash,
        }
    )
# Hardcoded non-tar dependencies
print(
    """opensymbol = fetchurl {
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
};"""
)
print("}")
