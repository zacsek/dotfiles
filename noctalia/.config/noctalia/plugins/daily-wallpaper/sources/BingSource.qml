import QtQuick

QtObject {
    id: root

    function fetchBingImage(locale, httpGet) {
        const response = httpGet(`https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=${locale}`);
        const parsed = JSON.parse(response);
        return parsed?.images?.[0] || ({});
    }

    function resolveDownload(locale, httpGet) {
        const image = fetchBingImage(locale, httpGet);
        const urlBase = image.urlbase || "";
        if (!urlBase) {
            throw new Error(`Failed to extract Bing urlbase for locale ${locale}`);
        }

        return {
            prefix: "bing",
            primaryUrl: `https://www.bing.com${urlBase}_UHD.jpg`,
            fallbackUrl: `https://www.bing.com${urlBase}_1920x1080.jpg`,
            metadata: {
                title: image.title || "",
                copyright: image.copyright || "",
                link: image.copyrightlink || "",
                date: image.startdate || ""
            }
        };
    }
}
