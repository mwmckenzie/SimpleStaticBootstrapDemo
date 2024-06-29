<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!-- Define a key for grouping by the first letter of the location -->
    <xsl:key name="letter" match="row" use="substring(location, 1, 1)"/>

    <!-- Define the template for the root element -->
    <xsl:template match="/rows">
        <html>
            <head>
                <title>Roman Villas in Britain</title>
                <link rel="stylesheet" href="bootstrap.css"/>
            </head>
            <body>
                <div class="container mt-5">
                    <div class="jumbotron text-center">
                        <h1 class="display-4">Discover Roman Villas in Britain</h1>
                        <p class="lead">Explore detailed profiles of Roman villas, complete with historical context, official records, and precise locations on an interactive map.</p>
                    </div>

                    <div class="mb-4">
                        <h2>Table of Contents</h2>
                        <ul class="list-inline">
                            <xsl:for-each select="row[generate-id() = generate-id(key('letter', substring(location, 1, 1))[1])]">
                                <xsl:sort select="substring(location, 1, 1)"/>
                                <li class="list-inline-item">
                                    <a href="#{substring(location, 1, 1)}" class="btn btn-primary">
                                        <xsl:value-of select="substring(location, 1, 1)"/>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </div>

                    <xsl:for-each select="row[generate-id() = generate-id(key('letter', substring(location, 1, 1))[1])]">
                        <xsl:sort select="substring(location, 1, 1)"/>
                        <div class="mb-5">
                            <h2 id="{substring(location, 1, 1)}" class="border-bottom pb-2">
                                <xsl:value-of select="substring(location, 1, 1)"/>
                            </h2>
                            <div class="row">
                                <xsl:for-each select="key('letter', substring(location, 1, 1))">
                                    <xsl:sort select="location"/>
                                    <xsl:call-template name="card"/>
                                </xsl:for-each>
                            </div>
                        </div>
                    </xsl:for-each>
                </div>

                <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
                <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            </body>
        </html>
    </xsl:template>

    <!-- Template for each card -->
    <xsl:template name="card">
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="card-title">
                        <xsl:value-of select="location"/>
                    </h5>
                    <p class="card-text"><strong>Area:</strong> <xsl:value-of select="area"/></p>
                    <p class="card-text"><strong>Coordinates:</strong> <xsl:value-of select="coordinates"/></p>
                    <p class="card-text"><strong>Latitude:</strong> <xsl:value-of select="format-number(latitude, '#0.0000')"/></p>
                    <p class="card-text"><strong>Longitude:</strong> <xsl:value-of select="format-number(longitude, '#0.0000')"/></p>
                    <a href="{concat('https://en.wikipedia.org', wiki_link)}" target="_blank" class="btn btn-info mb-2">Wikipedia</a>
                    <a href="{heritage_link}" target="_blank" class="btn btn-info mb-2">Heritage Gateway</a>
                    <div class="embed-responsive ratio ratio-16x9">
                        <iframe class="embed-responsive-item"
                                style="border:0"
                                loading="lazy"
                                allowfullscreen="true"
                                src="https://maps.google.com/maps?q={latitude},{longitude}&amp;z=16&amp;output=embed">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    

</xsl:stylesheet>