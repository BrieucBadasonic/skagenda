
<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/BrieucBadasonic/skagenda"> Moonstomp Agenda </a>

  <p align="center">
    My first post Le Wagon bootcamp project
    <br />
    <br />
    <a href="https://moonstomp-agenda.herokuapp.com">Go to the website</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

I wanted to keep on solidify my backend knowledge after finishing my Web Dev. bootcamp at Le Wagon Berlin in march 2021.

The purpose of this website is to centralize upcoming soul, rocksteady and ska show in Europe so fan's doen't have to follow tons
of Facebook groups to be aware of interestings shows around them.

Anybody will be able to add a new show but they will have to be validated by an admin before being published.
I want that mechanism so we make sure the added event a related to the Music scene we ant to promote and we will check
that those event are not promoting any kind of discriminations.


## Built With

* Ruby On Rails framework
* PostgreSQL Database
* HTML, CSS, SCSS and Javascript
* Heroku for production


## Tech I wanted to solidify

* Authentication & Authorisation
I'm using the DEVISE gem to deal with authentication.
I'm using the PUNDIT gem to deal with authorization.

User don't need to log in te see she index of the events.

User will have to log in to add a new event .
                            edit or delete a show they had created.

Some user will be defined as "Admin users".
Those user will have an extra tab in the nav bar to "Validate events".
Admin will have the right to edit and delete any events.

## Database schema

<img src="./app/assets/images/db_schema.png" alt="DB schema">


### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/BrieucBadasonic/skagenda.git
   ```
2. Install NPM packages
   ```sh
   npm install
   ```



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/BrieucBadasonic/skagenda/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Brieuc Labiouse - [@twitter_handle]() - email

Project Link: [https://github.com/BrieucBadasonic/skagenda](https://moonstomp-agenda.herokuapp.com)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* []()
* []()
* []()





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/BrieucBadasonic/repo.svg?style=for-the-badge
[contributors-url]: https://github.com/BrieucBadasonic/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/BrieucBadasonic/repo.svg?style=for-the-badge
[forks-url]: https://github.com/BrieucBadasonic/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/BrieucBadasonic/repo.svg?style=for-the-badge
[stars-url]: https://github.com/BrieucBadasonic/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/BrieucBadasonic/repo.svg?style=for-the-badge
[issues-url]: https://github.com/BrieucBadasonic/repo/issues
[license-shield]: https://img.shields.io/github/license/BrieucBadasonic/repo.svg?style=for-the-badge
[license-url]: https://github.com/BrieucBadasonic/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/brieuc-labiouse/
