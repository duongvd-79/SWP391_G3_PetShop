<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/header/userProfile.css">
<div id="profile" class="overlay">
    <div class="container rounded bg-white mt-md-2 mt-lg-5 mb-md-2 mb-lg-5 pb-4">
        <form action="userprofile" method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-4 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <h2 class="text-right"><strong>Profile Picture</strong></h2>
                        <img class="rounded-circle my-3" id="preview-img" width="150px" height="150px" src="${sessionScope.user.pfp}" onerror="this.src='images/userpfp/default.png';this.onerror='';">
                        <input id="file-upload" type="file" name="profilepfp" accept="image/*">
                        <label for="file-upload" class="custom-file-upload mt-2">Upload Image</label>
                        <span id="file-name"></span>
                    </div>
                </div>
                <div class="col-md-8 border-right">
                    <div class="p-3 pt-5 pb-3">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h2 class="text-right"><strong>User Profile</strong></h2>
                            <a class="close" href="#">&times;</a>
                        </div>
                        <div class="row">
                            <div class="col-md-12 col-lg-6 border-left border-right">
                                <div class="mb-2">
                                    <h3><strong>Information</strong></h3>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-md-12">
                                        <label class="labels">Name</label>
                                        <input type="text" class="form-control" name="pfname" id="pfname" pattern="^[A-Za-z]+( [A-Za-z]+)*$" placeholder="Enter Name" value="${sessionScope.user.name}" required>
                                        <span id="name-info" class="info-popup">Letters only, max 50 characters</span>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-12">
                                        <label class="labels">Email</label>
                                        <input type="text" class="form-control" id="pfemail" value="${sessionScope.user.email}" disabled readonly>
                                        <span id="email-info" class="info-popup">You cannot change your email once registered</span>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-2">
                                        <label class="labels">Gender</label>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="radio" name="pfgender" id="pfmale" value="Male" ${sessionScope.user.gender eq 'Male' ? "checked" : ""}>
                                        <label class="form-check-label">Male</label>
                                    </div>
                                    <div class="col-md-4">
                                        <input type="radio" name="pfgender" id="pffemale" value="Female" ${sessionScope.user.gender eq 'Female' ? "checked" : ""}>
                                        <label class="form-check-label">Female</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 col-lg-6 border-left border-right">
                                <div class="mb-2">
                                    <h3><strong>Contact</strong></h3>
                                </div>
                                <div class="row mt-1">
                                    <div class="col-md-6">
                                        <label class="labels">City</label>
                                        <select class="form-select p-2" name="pfcity" id="pfcity" style="max-width: 150px" required>
                                            <option ${sessionScope.address.getCity() == null ? 'selected' : ''}>City</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">District</label>
                                        <br>
                                        <select class="form-select p-2" name="pfdistrict" id="pfdistrict" style="max-width: 120px" required>
                                            <option ${sessionScope.address.getCity() == null ? 'selected' : ''}>District</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-12">
                                        <label class="labels">Detailed Address</label>
                                        <input type="text" class="form-control" name="pfdetailaddress" id="pfdetailaddress" placeholder="Enter address" value="${sessionScope.address.getDetail()}" required>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-3">
                                        <label class="labels">Phone</label>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" class="form-control" name="pfphone" id="pfphone" pattern="^[0-9]{10}$" placeholder="Enter Phone" value="${sessionScope.user.phone}" required>
                                        <span id="phone-info" class="info-popup">Numbers only, max 10 characters</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="mt-3 text-center">
                <button class="btn btn-primary" id="save-button" type="submit" disabled>Save Profile</button>
            </div>
        </form>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
    // Field guide popup
    const nameInput = document.getElementById('pfname');
    const nameInfo = document.getElementById('name-info');
    const emailInput = document.getElementById('pfemail');
    const emailInfo = document.getElementById('email-info');
    const phoneInput = document.getElementById('pfphone');
    const phoneInfo = document.getElementById('phone-info');

    nameInput.addEventListener('focus', () => {
        nameInfo.style.display = 'block';
    });
    nameInput.addEventListener('blur', () => {
        nameInfo.style.display = 'none';
    });

    emailInput.addEventListener('mouseover', () => {
        emailInfo.style.display = 'block';
    });
    emailInput.addEventListener('mouseout', () => {
        emailInfo.style.display = 'none';
    });

    phoneInput.addEventListener('focus', () => {
        phoneInfo.style.display = 'block';
    });
    phoneInput.addEventListener('blur', () => {
        phoneInfo.style.display = 'none';
    });

    // Render cites & districts
    var cities = document.getElementById("pfcity");
    var districts = document.getElementById("pfdistrict");

    var Parameter = {
        url: "js/data.json",
        method: "GET",
        responseType: "application/json",
    };

    var promise = axios(Parameter);
    promise.then(function (result) {
        renderCity(result.data);
    });

    function renderCity(data) {
        for (const city of data) {
            const option = new Option(city.Name);
            option.value = city.Name;
            option.selected = city.Name === '${sessionScope.address.getCity()}';
            cities.add(option);
        }

        if (cities.value !== "") {
            renderDistrict(cities.value, data);
        }
        cities.onchange = function () {
            renderDistrict(this.value, data);
        };

        function renderDistrict(selectedCityName, data) {
            districts.length = 1;

            if (selectedCityName !== "") {
                const selectedCity = data.find(city => city.Name === selectedCityName);

                for (const district of selectedCity.Districts) {
                    const option = new Option(district.Name);
                    option.value = district.Name;
                    option.selected = district.Name === '${sessionScope.address.getDistrict()}';
                    districts.add(option);
                }
            }
        }
    }
    
    // Image upload
    var file = document.getElementById('file-upload');
    var previewImage = document.getElementById('preview-img');

    file.addEventListener('change', function () {
        var fileName = this.files[0].name;
        document.getElementById('file-name').textContent = fileName;
    });
    file.addEventListener('change', (e) => {
        var reader = new FileReader();

        reader.onload = (event) => {
            previewImage.src = event.target.result;
        };
        reader.readAsDataURL(e.target.files[0]);
    });
    
    // Toggle save button on changes
    document.addEventListener('DOMContentLoaded', function () {
        var name = document.getElementById('pfname');
        var phone = document.getElementById('pfphone');
        var male = document.getElementById('pfmale')
        var female = document.getElementById('pffemale')
        var city = document.getElementById('pfcity');
        var district = document.getElementById('pfdistrict');
        var detailaddress = document.getElementById('pfdetailaddress');
        var saveButton = document.getElementById('save-button');
        const originalName = '${sessionScope.user.name}';
        const originalPhone = '${sessionScope.user.phone}';
        const originalGender = '${sessionScope.user.gender}';
        const originalCity = '${sessionScope.address.city}';
        const originalDistrict = '${sessionScope.address.district}';
        const originalDetailAddress = '${sessionScope.address.detail}';

        function toggleButton() {
            if (name.value !== originalName || phone.value !== originalPhone
                    || (originalGender === 'Male' && female.checked)
                    || (originalGender === 'Female' && male.checked)
                    || file.value !== '' || city.value !== originalCity
                    || district.value !== originalDistrict
                    || detailaddress.value !== originalDetailAddress) {
                saveButton.disabled = false;
            } else {
                saveButton.disabled = true;
            }
        };

        name.addEventListener('input', toggleButton);
        phone.addEventListener('input', toggleButton);
        male.addEventListener('change', toggleButton);
        female.addEventListener('change', toggleButton);
        file.addEventListener('change', toggleButton);
        city.addEventListener('change', toggleButton);
        district.addEventListener('change', toggleButton);
        detailaddress.addEventListener('input', toggleButton);
    });
</script>
