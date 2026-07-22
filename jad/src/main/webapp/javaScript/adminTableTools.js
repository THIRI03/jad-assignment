/*
JAD-CA1
Class-DIT/FT/2A/23
Student Name: Moe Myat Thwe
Admin No.: P2340362
*/

function setupTableTools(options) {
    const tableBody = document.querySelector(
        options.tableBodySelector
    );

    const searchInput = document.querySelector(
        options.searchInputSelector
    );

    const paginationContainer = document.querySelector(
        options.paginationSelector
    );

    if (!tableBody || !searchInput || !paginationContainer) {
        console.error(
            "Table tools could not find the required elements."
        );
        return;
    }

    const rowsPerPage = options.rowsPerPage || 10;

    const noResultsMessage =
        options.noResultsMessage || "No matching records found.";

    const columnCount =
        options.columnCount || 1;

    /*
     * Only rows containing data-search are treated
     * as actual data rows.
     */
    const allRows = Array.from(
        tableBody.querySelectorAll("tr[data-search]")
    );

    let filteredRows = [...allRows];
    let currentPage = 1;

    function renderTable() {
        const totalRecords = filteredRows.length;

        /*
         * Always use at least one page so pagination
         * does not become zero pages.
         */
        const totalPages = Math.max(
            1,
            Math.ceil(totalRecords / rowsPerPage)
        );

        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        /*
         * Hide all original data rows first.
         */
        allRows.forEach(function (row) {
            row.style.display = "none";
        });

        const startIndex =
            (currentPage - 1) * rowsPerPage;

        const endIndex =
            startIndex + rowsPerPage;

        const rowsForCurrentPage =
            filteredRows.slice(startIndex, endIndex);

        rowsForCurrentPage.forEach(function (row) {
            row.style.display = "";
        });

        showNoResultsMessage(totalRecords === 0);
        renderPagination(totalPages);
    }

    function showNoResultsMessage(shouldShow) {
        let noResultsRow = tableBody.querySelector(
            ".search-no-results"
        );

        if (shouldShow) {
            if (!noResultsRow) {
                noResultsRow =
                    document.createElement("tr");

                noResultsRow.className =
                    "search-no-results";

                const cell =
                    document.createElement("td");

                cell.colSpan = columnCount;
                cell.className = "empty-message";
                cell.textContent = noResultsMessage;

                noResultsRow.appendChild(cell);
                tableBody.appendChild(noResultsRow);
            }

            noResultsRow.style.display = "";

        } else if (noResultsRow) {
            noResultsRow.style.display = "none";
        }
    }

    function renderPagination(totalPages) {
        paginationContainer.innerHTML = "";

        const previousButton = createPageButton(
            "← Previous",
            currentPage - 1,
            currentPage === 1
        );

        paginationContainer.appendChild(
            previousButton
        );

        for (
            let pageNumber = 1;
            pageNumber <= totalPages;
            pageNumber++
        ) {
            const pageButton = createPageButton(
                String(pageNumber),
                pageNumber,
                false
            );

            if (pageNumber === currentPage) {
                pageButton.classList.add("active");

                pageButton.setAttribute(
                    "aria-current",
                    "page"
                );
            }

            paginationContainer.appendChild(
                pageButton
            );
        }

        const nextButton = createPageButton(
            "Next →",
            currentPage + 1,
            currentPage === totalPages
        );

        paginationContainer.appendChild(
            nextButton
        );
    }

    function createPageButton(
        label,
        targetPage,
        disabled
    ) {
        const button =
            document.createElement("button");

        button.type = "button";
        button.textContent = label;
        button.className = "page-button";
        button.disabled = disabled;

        button.addEventListener(
            "click",
            function () {
                currentPage = targetPage;
                renderTable();
            }
        );

        return button;
    }

    function filterRows() {
        const keyword = searchInput.value
            .trim()
            .toLowerCase();

        filteredRows = allRows.filter(
            function (row) {
                const searchableText = (
                    row.dataset.search || ""
                ).toLowerCase();

                return searchableText.includes(
                    keyword
                );
            }
        );

        currentPage = 1;
        renderTable();
    }

    searchInput.addEventListener(
        "input",
        filterRows
    );

    renderTable();
}