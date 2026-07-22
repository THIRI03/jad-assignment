/*
JAD-CA1
Class-DIT/FT/2A/23
Student Name: Thiri Lae Win, Moe Myat Thwe
Admin No.: P2340739, P2340362
*/

document.addEventListener("DOMContentLoaded", function () {

    const tableBody =
        document.querySelector("#bookingTableBody");

    const searchInput =
        document.querySelector("#bookingSearch");

    const paginationContainer =
        document.querySelector("#bookingPagination");

    const resetButton =
        document.querySelector("#resetBookingFilters");

    const resultCount =
        document.querySelector("#bookingResultCount");

    const dateFromFilter =
        document.querySelector("#dateFromFilter");

    const dateToFilter =
        document.querySelector("#dateToFilter");

    const categoryCheckboxes =
        document.querySelectorAll(
            "#categoryFilter input[type='checkbox']"
        );

    const statusCheckboxes =
        document.querySelectorAll(
            "#statusFilter input[type='checkbox']"
        );

    const addressCheckboxes =
        document.querySelectorAll(
            "#addressFilter input[type='checkbox']"
        );

    if (
        !tableBody ||
        !searchInput ||
        !paginationContainer ||
        !resetButton ||
        !dateFromFilter ||
        !dateToFilter
    ) {
        console.error(
            "Booking filter elements could not be found."
        );

        return;
    }

    const rowsPerPage = 10;

    /*
     * Only rows with data-category are booking records.
     */
    const allRows = Array.from(
        tableBody.querySelectorAll(
            "tr[data-category]"
        )
    );

    let filteredRows = [...allRows];
    let currentPage = 1;

    setupDropdownMenus();

    /*
     * Opens and closes the filter dropdown menus.
     */
    function setupDropdownMenus() {

        const dropdownButtons =
            document.querySelectorAll(
                ".filter-dropdown-button"
            );

        const dropdownMenus =
            document.querySelectorAll(
                ".filter-dropdown-menu"
            );

        dropdownButtons.forEach(function (button) {

            button.addEventListener(
                "click",
                function (event) {

                    event.stopPropagation();

                    const targetId =
                        button.dataset.filterTarget;

                    const targetMenu =
                        document.querySelector(
                            "#" + targetId
                        );

                    dropdownMenus.forEach(
                        function (menu) {

                            if (menu !== targetMenu) {
                                menu.classList.remove(
                                    "show"
                                );
                            }
                        }
                    );

                    if (targetMenu) {
                        targetMenu.classList.toggle(
                            "show"
                        );
                    }
                }
            );
        });

        dropdownMenus.forEach(function (menu) {

            menu.addEventListener(
                "click",
                function (event) {

                    /*
                     * Prevent clicking inside a menu
                     * from immediately closing it.
                     */
                    event.stopPropagation();
                }
            );
        });

        document.addEventListener(
            "click",
            function () {

                dropdownMenus.forEach(
                    function (menu) {

                        menu.classList.remove(
                            "show"
                        );
                    }
                );
            }
        );
    }

    /*
     * Gets all checked values from one filter.
     */
    function getCheckedValues(checkboxes) {

        return Array.from(checkboxes)
            .filter(function (checkbox) {

                return checkbox.checked;
            })
            .map(function (checkbox) {

                return checkbox.value
                    .trim()
                    .toLowerCase();
            });
    }

    /*
     * When nothing is selected, all rows pass.
     *
     * When values are selected, the row must match
     * one of the selected values.
     */
    function matchesCheckedValues(
        rowValue,
        selectedValues
    ) {
        if (selectedValues.length === 0) {
            return true;
        }

        return selectedValues.includes(
            rowValue.trim().toLowerCase()
        );
    }

    function applyFilters() {

        const keyword = searchInput.value
            .trim()
            .toLowerCase();

        const selectedCategories =
            getCheckedValues(
                categoryCheckboxes
            );

        const selectedStatuses =
            getCheckedValues(
                statusCheckboxes
            );

        const selectedAddresses =
            getCheckedValues(
                addressCheckboxes
            );

        const fromDate =
            dateFromFilter.value;

        const toDate =
            dateToFilter.value;

        filteredRows = allRows.filter(
            function (row) {

                const rowText = row.textContent
                    .replace(/\s+/g, " ")
                    .trim()
                    .toLowerCase();

                const rowCategory =
                    row.dataset.category || "";

                const rowStatus =
                    row.dataset.status || "";

                const rowAddress =
                    row.dataset.address || "";

                const rowDate =
                    row.dataset.date || "";

                const matchesKeyword =
                    keyword === ""
                    || rowText.includes(keyword);

                const matchesCategory =
                    matchesCheckedValues(
                        rowCategory,
                        selectedCategories
                    );

                const matchesStatus =
                    matchesCheckedValues(
                        rowStatus,
                        selectedStatuses
                    );

                const matchesAddress =
                    matchesCheckedValues(
                        rowAddress,
                        selectedAddresses
                    );

                const matchesFromDate =
                    fromDate === ""
                    || rowDate >= fromDate;

                const matchesToDate =
                    toDate === ""
                    || rowDate <= toDate;

                return (
                    matchesKeyword
                    && matchesCategory
                    && matchesStatus
                    && matchesAddress
                    && matchesFromDate
                    && matchesToDate
                );
            }
        );

        currentPage = 1;

        updateAllFilterButtons();
        updateDateFilterButton();
        renderTable();
    }

    function updateAllFilterButtons() {

        updateFilterButton(
            "categoryFilterMenu",
            categoryCheckboxes
        );

        updateFilterButton(
            "statusFilterMenu",
            statusCheckboxes
        );

        updateFilterButton(
            "addressFilterMenu",
            addressCheckboxes
        );
    }

    /*
     * Adds a number to the button when options
     * are selected.
     *
     * Example: Category 2
     */
    function updateFilterButton(
        menuId,
        checkboxes
    ) {
        const menu =
            document.querySelector(
                "#" + menuId
            );

        if (!menu) {
            return;
        }

        const dropdown =
            menu.closest(".filter-dropdown");

        if (!dropdown) {
            return;
        }

        const button =
            dropdown.querySelector(
                ".filter-dropdown-button"
            );

        if (!button) {
            return;
        }

        let countBadge =
            button.querySelector(
                ".filter-count"
            );

        const selectedCount =
            Array.from(checkboxes)
                .filter(function (checkbox) {

                    return checkbox.checked;
                })
                .length;

        if (selectedCount > 0) {

            button.classList.add(
                "has-filter"
            );

            if (!countBadge) {

                countBadge =
                    document.createElement(
                        "span"
                    );

                countBadge.className =
                    "filter-count";

                button.appendChild(
                    countBadge
                );
            }

            countBadge.textContent =
                String(selectedCount);

        } else {

            button.classList.remove(
                "has-filter"
            );

            if (countBadge) {
                countBadge.remove();
            }
        }
    }

    /*
     * Highlights the Booking Date button when
     * a starting or ending date is selected.
     */
    function updateDateFilterButton() {

        const menu =
            document.querySelector(
                "#dateFilterMenu"
            );

        if (!menu) {
            return;
        }

        const dropdown =
            menu.closest(".filter-dropdown");

        const button =
            dropdown.querySelector(
                ".filter-dropdown-button"
            );

        if (
            dateFromFilter.value !== ""
            || dateToFilter.value !== ""
        ) {
            button.classList.add(
                "has-filter"
            );

        } else {
            button.classList.remove(
                "has-filter"
            );
        }
    }

    function renderTable() {

        const totalRecords =
            filteredRows.length;

        const totalPages = Math.max(
            1,
            Math.ceil(
                totalRecords / rowsPerPage
            )
        );

        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        if (currentPage < 1) {
            currentPage = 1;
        }

        /*
         * Hide all booking rows first.
         */
        allRows.forEach(function (row) {

            row.style.display = "none";
        });

        const startIndex =
            (currentPage - 1)
            * rowsPerPage;

        const endIndex =
            startIndex
            + rowsPerPage;

        const currentPageRows =
            filteredRows.slice(
                startIndex,
                endIndex
            );

        currentPageRows.forEach(
            function (row) {

                row.style.display = "";
            }
        );

        if (resultCount) {

            resultCount.textContent =
                String(totalRecords);
        }

        showNoResultsMessage(
            totalRecords === 0
        );

        renderPagination(
            totalPages
        );
    }

    function showNoResultsMessage(
        shouldShow
    ) {
        let noResultsRow =
            tableBody.querySelector(
                ".booking-no-results"
            );

        if (shouldShow) {

            if (!noResultsRow) {

                noResultsRow =
                    document.createElement(
                        "tr"
                    );

                noResultsRow.className =
                    "booking-no-results";

                const cell =
                    document.createElement(
                        "td"
                    );

                cell.colSpan = 13;

                cell.className =
                    "empty-message";

                cell.textContent =
                    "No bookings match the selected filters.";

                noResultsRow.appendChild(
                    cell
                );

                tableBody.appendChild(
                    noResultsRow
                );
            }

            noResultsRow.style.display = "";

        } else if (noResultsRow) {

            noResultsRow.style.display =
                "none";
        }
    }

    function renderPagination(
        totalPages
    ) {
        paginationContainer.innerHTML =
            "";

        const previousButton =
            createPageButton(
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
            const pageButton =
                createPageButton(
                    String(pageNumber),
                    pageNumber,
                    false
                );

            if (
                pageNumber === currentPage
            ) {
                pageButton.classList.add(
                    "active"
                );

                pageButton.setAttribute(
                    "aria-current",
                    "page"
                );
            }

            paginationContainer.appendChild(
                pageButton
            );
        }

        const nextButton =
            createPageButton(
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
            document.createElement(
                "button"
            );

        button.type = "button";
        button.textContent = label;
        button.className =
            "page-button";
        button.disabled = disabled;

        button.addEventListener(
            "click",
            function () {

                currentPage =
                    targetPage;

                renderTable();
            }
        );

        return button;
    }

    function clearCheckboxes(
        checkboxes
    ) {
        checkboxes.forEach(
            function (checkbox) {

                checkbox.checked =
                    false;
            }
        );
    }

    function resetFilters() {

        searchInput.value = "";

        clearCheckboxes(
            categoryCheckboxes
        );

        clearCheckboxes(
            statusCheckboxes
        );

        clearCheckboxes(
            addressCheckboxes
        );

        dateFromFilter.value = "";
        dateToFilter.value = "";

        filteredRows = [...allRows];
        currentPage = 1;

        updateAllFilterButtons();
        updateDateFilterButton();
        renderTable();
    }

    searchInput.addEventListener(
        "input",
        applyFilters
    );

    categoryCheckboxes.forEach(
        function (checkbox) {

            checkbox.addEventListener(
                "change",
                applyFilters
            );
        }
    );

    statusCheckboxes.forEach(
        function (checkbox) {

            checkbox.addEventListener(
                "change",
                applyFilters
            );
        }
    );

    addressCheckboxes.forEach(
        function (checkbox) {

            checkbox.addEventListener(
                "change",
                applyFilters
            );
        }
    );

    dateFromFilter.addEventListener(
        "change",
        applyFilters
    );

    dateToFilter.addEventListener(
        "change",
        applyFilters
    );

    resetButton.addEventListener(
        "click",
        resetFilters
    );

    renderTable();
});