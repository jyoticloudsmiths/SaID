import { LightningElement } from 'lwc';
import getDetails from '@salesforce/apex/SearchSAID.search';

export default class SearchSAID extends LightningElement {
    // Properties
    searchKey;
    disableButton = true;
    showResult = false;
    showError = false;
    errorMessage = '';
    resultapex = [];
    error;

    ButtonClickHandler() {
        this.showResult = false;
        if (this.validateLuhn(this.searchKey) && this.validateCitizenship(this.searchKey)) {
            getDetails({ saID: this.searchKey })
                .then((result) => {
                    this.resultapex = result;
                    if (this.resultapex) {
                        this.showResult = true;
                        this.showError = false;
                        this.errorMessage = '';
                    }
                })
                .catch((error) => {
                    this.resultapex = [];
                    this.showError = true;
                    this.errorMessage = 'System Error : ' + error.body.message;
                });
        } else {
            this.resultapex = [];
            this.showResult = false;
            this.showError = true;
            this.errorMessage = 'This is an invalid ID. A valid ID has 13 numeric digits.';
        }
    }
    handleChange(event) {
        this.searchKey = event.target.value;
        if (this.searchKey.length === 13) this.disableButton = false;
        else this.disableButton = true;
    }
    //  The SAID is invalid if the digit at 11th place is neither 0 nor 1. If SA-ID is invalid, server call will not be made.
    validateCitizenship = (saID) => {
        let citizenshipDigit = parseInt(saID.substring(10, 11), 10);
        if (citizenshipDigit >= 0 && citizenshipDigit <= 1) {
            return true;
        } else {
            return false;
        }
    };
    // The SA ID number should follow Luhn's algorithm, if the SA-ID is invalid, server call will not be made.
    validateLuhn = (saID) => {
        let nSum = 0;
        let isSecond = false;
        for (let i = saID.length - 1; i >= 0; i--) {
            let d = saID[i].charCodeAt() - '0'.charCodeAt();
            if (isSecond == true) d = d * 2;
            nSum += parseInt(d / 10, 10);
            nSum += d % 10;
            isSecond = !isSecond;
        }
        return nSum % 10 == 0;
    };
}