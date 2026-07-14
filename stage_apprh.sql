-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 04 août 2025 à 17:08
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `stage_apprh`
--

-- --------------------------------------------------------

--
-- Structure de la table `anomalie_paie`
--

CREATE TABLE `anomalie_paie` (
  `id` bigint(20) NOT NULL,
  `date_anomalie` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL,
  `type_anomalie` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `anomalie_paie`
--

INSERT INTO `anomalie_paie` (`id`, `date_anomalie`, `description`, `employe_id`, `type_anomalie`, `statut`) VALUES
(1, '2025-07-01', '', 448, 'Avance', 'Acceptée'),
(2, '2025-07-01', 'knzdcjnksc', 552, 'Pointage oublié', 'Refusée'),
(3, '2025-07-02', 'knzdcjnksc', 448, 'RIB', 'En attente'),
(4, '2025-07-02', 'knzdcjnksc', 448, 'Prime', 'En attente'),
(5, '2025-07-02', 'knzdcjnksc', 448, 'Avance', 'En attente'),
(6, '2025-07-02', 'knzdcjnksc', 448, 'Pointage oublié', 'En attente'),
(7, '2025-07-02', 'knzdcjnksc', 448, 'Nombre Heure', 'Refusée'),
(10, '2025-07-02', '', 448, 'Avance', 'En attente');

-- --------------------------------------------------------

--
-- Structure de la table `anomalie_pointage`
--

CREATE TABLE `anomalie_pointage` (
  `id` bigint(20) NOT NULL,
  `date_demande` date DEFAULT NULL,
  `remarque` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type_anomalie` enum('ENTREE','SORTIE') DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `anomalie_pointage`
--

INSERT INTO `anomalie_pointage` (`id`, `date_demande`, `remarque`, `statut`, `type_anomalie`, `employe_id`) VALUES
(1, '2025-06-27', 'GGG', 'Refusée', 'SORTIE', 448),
(2, '2025-06-27', 'Je vous remercie par avance pour le traitement de ma situation de présence.', 'Acceptée', 'ENTREE', 552),
(52, '2025-06-29', 'HHHH', 'En attente', 'SORTIE', 448),
(102, '2025-07-02', '', 'En attente', 'SORTIE', 247);

-- --------------------------------------------------------

--
-- Structure de la table `anomalie_pointage_seq`
--

CREATE TABLE `anomalie_pointage_seq` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `anomalie_pointage_seq`
--

INSERT INTO `anomalie_pointage_seq` (`next_val`) VALUES
(201);

-- --------------------------------------------------------

--
-- Structure de la table `autorisation`
--

CREATE TABLE `autorisation` (
  `id` bigint(20) NOT NULL,
  `date` date DEFAULT NULL,
  `motif` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL,
  `heure_debut` time(6) DEFAULT NULL,
  `heure_fin` time(6) DEFAULT NULL,
  `direction` varchar(255) DEFAULT NULL,
  `validation_chef_securite` varchar(255) DEFAULT NULL,
  `validation_responsable_hierarchique` varchar(255) DEFAULT NULL,
  `validation_responsablerh` varchar(255) DEFAULT NULL,
  `motif_refus` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `autorisation`
--

INSERT INTO `autorisation` (`id`, `date`, `motif`, `statut`, `type`, `employe_id`, `heure_debut`, `heure_fin`, `direction`, `validation_chef_securite`, `validation_responsable_hierarchique`, `validation_responsablerh`, `motif_refus`) VALUES
(62, '2025-07-04', 'Medicale', 'En attente', 'Heure', 448, '12:41:00.000000', NULL, 'Entrée', 'En attente', 'Accepté', 'Accepté', NULL),
(63, '2025-08-07', 'Medicale', 'En attente', 'Heure', 175, '14:37:00.000000', '15:37:00.000000', 'Sortie', 'En attente', 'Accepté', 'En attente', NULL),
(64, '2025-08-05', 'Medicale', 'En attente', 'Heure', 59, '16:44:00.000000', '17:44:00.000000', 'Sortie', 'En attente', 'En attente', 'En attente', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `avance_salaire`
--

CREATE TABLE `avance_salaire` (
  `id` bigint(20) NOT NULL,
  `date_demande` date DEFAULT NULL,
  `matricule` varchar(255) DEFAULT NULL,
  `montant` double DEFAULT NULL,
  `remarque` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `avance_salaire`
--

INSERT INTO `avance_salaire` (`id`, `date_demande`, `matricule`, `montant`, `remarque`, `statut`, `employe_id`) VALUES
(1, '2025-06-27', NULL, 500, 'NFFF', 'En attente', 448),
(2, '2025-06-27', NULL, 200, 'Urgent', 'Acceptée', 552),
(52, '2025-06-27', NULL, 560, 'Urgent SVP', 'En attente', 448),
(152, '2025-07-02', NULL, 100, '', 'En attente', 247),
(153, '2025-07-02', NULL, 200, '', 'En attente', 448),
(202, '2025-07-02', NULL, 200, '', 'En attente', 448);

-- --------------------------------------------------------

--
-- Structure de la table `avance_salaire_seq`
--

CREATE TABLE `avance_salaire_seq` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `avance_salaire_seq`
--

INSERT INTO `avance_salaire_seq` (`next_val`) VALUES
(301);

-- --------------------------------------------------------

--
-- Structure de la table `conge`
--

CREATE TABLE `conge` (
  `id` bigint(20) NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL,
  `validation_chef_securite` varchar(255) DEFAULT NULL,
  `validation_responsable_hierarchique` varchar(255) DEFAULT NULL,
  `validation_responsablerh` varchar(255) DEFAULT NULL,
  `motif_refus` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `conge`
--

INSERT INTO `conge` (`id`, `date_debut`, `date_fin`, `statut`, `type`, `employe_id`, `validation_chef_securite`, `validation_responsable_hierarchique`, `validation_responsablerh`, `motif_refus`) VALUES
(34, '2025-06-29', '2025-07-29', 'Accepté', 'Conge Annuel', 190, 'Accepté', 'Accepté', 'Accepté', NULL),
(37, '2025-07-02', '2025-07-04', 'Accepté', 'Annuel', 76, 'Accepté', 'Accepté', 'Accepté', NULL),
(38, '2025-07-05', '2025-07-06', 'Refusé', 'Annuel', 76, 'En attente', 'Refusé', 'Accepté', NULL),
(39, '2025-07-01', '2025-07-06', 'Accepté', 'medicale', 157, 'Accepté', 'Accepté', 'Accepté', NULL),
(40, '2025-07-06', '2025-07-19', 'Accepté', 'Annuel', 543, 'Accepté', 'Accepté', 'Accepté', NULL),
(41, '2025-07-04', '2025-07-06', 'Accepté', 'Annuel', 540, 'Accepté', 'Accepté', 'Accepté', NULL),
(42, '2025-06-20', '2025-06-28', 'Accepté', '', 291, 'Accepté', 'Accepté', 'Accepté', NULL),
(43, '2025-07-03', '2025-07-06', 'Accepté', 'Annuel', 83, 'Accepté', 'Accepté', 'Accepté', NULL),
(44, '2025-07-03', '2025-07-06', 'Accepté', 'Annuel', 465, 'Accepté', 'Accepté', 'Accepté', NULL),
(45, '2025-07-03', '2025-07-06', 'En attente', 'Annuel', 465, 'En attente', 'En attente', 'En attente', NULL),
(46, '2025-07-03', '2025-07-06', 'Accepté', 'Annuel', 67, 'Accepté', 'Accepté', 'Accepté', NULL),
(47, '2025-07-03', '2025-07-06', 'En attente', 'Annuel', 67, 'En attente', 'En attente', 'En attente', NULL),
(48, '2025-07-03', '2025-07-06', 'Accepté', 'Annuel', 67, 'Accepté', 'Accepté', 'Accepté', NULL),
(49, '2025-07-01', '2025-07-26', 'Accepté', 'Annuel', 138, 'Accepté', 'Accepté', 'Accepté', NULL),
(50, '2025-07-03', '2025-07-26', 'Accepté', 'Annuel', 543, 'Accepté', 'Accepté', 'Accepté', NULL),
(51, '2025-07-02', '2025-08-30', 'Accepté', '', 539, 'Accepté', 'Accepté', 'Accepté', NULL),
(53, '2025-07-04', '2025-07-04', 'En attente', 'medicale', 452, 'En attente', 'Accepté', 'Accepté', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `demande_document`
--

CREATE TABLE `demande_document` (
  `id` bigint(20) NOT NULL,
  `date_demande` date DEFAULT NULL,
  `remarque` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type_document` varchar(255) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `demande_document`
--

INSERT INTO `demande_document` (`id`, `date_demande`, `remarque`, `statut`, `type_document`, `employe_id`) VALUES
(2, '2025-06-26', NULL, 'Acceptée', 'Attestation de travail', 448),
(4, '2025-06-26', 'J\'ai besoin de cette document le plus tot possible s\'il vous plait', 'En attente', 'Attestation de travail', 75),
(5, '2025-06-26', 'Rien', 'En attente', 'Certificat de salaire', 76),
(8, '2025-06-27', NULL, 'Acceptée', 'Attestation de travail', 179),
(9, '2025-06-27', '', 'En attente', 'Relevé de carrière', 448),
(10, '2025-07-02', 'NNBH', 'En attente', 'Attestation de travail', 102),
(11, '2025-07-02', '', 'En attente', 'CNSS', 247);

-- --------------------------------------------------------

--
-- Structure de la table `emission`
--

CREATE TABLE `emission` (
  `id` bigint(20) NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `emission`
--

INSERT INTO `emission` (`id`, `date_debut`, `date_fin`, `statut`, `type`, `employe_id`) VALUES
(1, '2025-07-13', '2025-07-15', 'En attente', 'Voyage à l\'étranger', 448),
(2, '2025-07-13', '2025-07-15', 'Refusée', 'Formation', 448),
(3, '2025-07-18', '2025-07-25', 'Acceptée', 'Formation', 448),
(4, '2025-07-18', '2025-07-25', 'En attente', 'Client', 448),
(5, '2025-07-18', '2025-07-25', 'En attente', 'Voyage à l\'étranger', 448);

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

CREATE TABLE `employe` (
  `id` bigint(255) NOT NULL,
  `matricule` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `zone` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `employe`
--

INSERT INTO `employe` (`id`, `matricule`, `fullname`, `zone`, `role`, `password`) VALUES
(559, '1', 'Mohamed Sabri Chaarana', 'Direction', 'Directeur ', '1'),
(560, '2', 'HEDYEOUI RIDHA', 'Direction', 'Chef service technique', '2'),
(561, '7', 'BEL HADJ   JAMILA', 'Norsystec', 'ouvrier qualifier', NULL),
(562, '9', 'KHELIFA   SIHEM', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(563, '12', 'EL GHOUL   NEDRA', 'Norsystec', 'Chef de Groupe', NULL),
(564, '16', 'AOUIDIDI   NABIL', 'Norsystec', 'ouvrier qualifier', NULL),
(565, '17', 'RABBOUHI   AFEF', 'Norsystec', 'Agent de contr?le', NULL),
(566, '18', 'AYEDI   HAJER', 'Prod. Cable WH-E', 'Chef d\'equipe', NULL),
(567, '19', 'MAJEBRI   MOUNIRA', 'Norsystec', 'Agent de contr?le', NULL),
(568, '20', 'BELHADJ   SAMIA', 'Prod.Cable SET', 'Chef d\'equipe', NULL),
(569, '21', 'MAJDOUB   ABDELMAJID', 'Maintenance', 'Chef service logisti', NULL),
(570, '23', 'HALFEOUI   SELMA', 'Prod. Cable WH-E', 'Agent de contr?le', NULL),
(571, '24', 'REBEG    HELA', 'Prod.Cable SET', 'Chef d\'equipe', NULL),
(572, '26', 'BEN HNIA   HAYET', 'Norsystec', 'Chef d\'equipe', NULL),
(573, '28', 'KHELIFI   AWATEF', 'Norsystec', 'Chef d\'equipe', NULL),
(574, '29', 'KHELIFA   OLFA', 'Norsystec', 'Agent de contr?le', NULL),
(575, '30', 'KHELIFI   FATHIA', 'Prod.Cable SET', 'Agent de contr?le', NULL),
(576, '31', 'BEN NJIMA   AICHA', 'Prod. Cable WH-E', 'Agent de contr?le', NULL),
(577, '36', 'MEHRITHI   SALAH', 'Ressources Huamines', 'ouvrier qualifier', NULL),
(578, '42', 'BELHADJ   FOLLA', 'Prod.Cable SET', 'Chef d\'equipe', NULL),
(579, '47', 'BEN AMOR   MONIA', 'Norsystec', 'Couturiere permanant', NULL),
(580, '51', 'KHELIFI   MADIHA', 'Prod. Cable WH-E', 'ouvrier qualifier', NULL),
(581, '53', 'ELTAIEF   MOUFIDA', 'Norsystec', 'Couturiere permanant', NULL),
(582, '56', 'ZALFENI   AZIZA', 'Norsystec', 'Tournante', NULL),
(583, '58', 'NASR   AHMED', 'Direction', 'Chef Service Cable', '58'),
(584, '60', 'RAOUEFI   MONIA', 'Norsystec', 'Couturiere permanant', NULL),
(585, '65', 'KHELIFA   NOUHA', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(586, '72', 'KHELIFI   NEJIA', 'Norsystec', 'Agent de contr?le', NULL),
(587, '74', 'HAMDI   KHADIJA', 'Norsystec', 'Agent de contr?le', NULL),
(588, '76', 'CHOUIGUI   SAWSSEN', 'Norsystec', 'Tournante', NULL),
(589, '77', 'EL ARBI   SAWSSEN', 'Norsystec', 'OUVRIER(E)', NULL),
(590, '83', 'LTAIEF   AMAL', 'Norsystec', 'Couturiere permanant', NULL),
(591, '84', 'CHOUIGUI   AMIRA', 'Norsystec', 'Couturiere permanant', NULL),
(592, '86', 'KAZBOURI   KHITEM', 'Prod. Cable WH-E', 'Chef d\'equipe', NULL),
(593, '87', 'BEN HNIA   SONIA', 'Norsystec', 'Couturiere', NULL),
(594, '88', 'BEN HNIA   NAJEH', 'Prod. Cable WH-E', 'Chef d\'equipe', NULL),
(595, '90', 'BEN HNIA   HALIMA', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(596, '91', 'MAJDOUB   FRAJ', 'Maintenance', 'Tech maintenance-Pro', NULL),
(597, '95', 'HAMDI   RADHIA', 'Prod. Cable WH-E', 'Agent de contr?le', NULL),
(598, '100', 'KHELIFA    SONIA', 'Norsystec', 'Couturiere permanant', NULL),
(599, '103', 'ABDEOUI   YOSRA', 'Norsystec', 'Formatrice', NULL),
(600, '104', 'BOUKAMCHA   SONIA', 'Norsystec', 'Couturiere permanant', NULL),
(601, '105', 'KESSEBI   MADIHA', 'Norsystec', 'Couturiere permanant', NULL),
(602, '111', 'HRAIECH   NORHEN', 'Norsystec', 'Chef d\'equipe', NULL),
(603, '112', 'ERRAIED   HADDA', 'Norsystec', 'Agent de contrôle', NULL),
(604, '115', 'Ines BAHLOUL', 'Norsystec', 'Agent de contrôle', NULL),
(605, '118', 'NAHERI   MARWEN', 'Logistique', 'Magasinier', NULL),
(606, '122', 'DHAYA   IMEN', 'Norsystec', 'Agent de contrôle', NULL),
(607, '128', 'BOUZAABIA   SALWA', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(608, '129', 'RABBOUHI   NAZIHA', 'Prod. Cable WH-E', 'AGENT DE CONTROLE TI', NULL),
(609, '136', 'BOURAOUI   FADOUA', 'Norsystec', 'ouvrier qualifier', NULL),
(610, '137', 'ABID   AYMEN', 'Logistique', 'Magasinier', NULL),
(611, '146', 'AOUNI   SIHEM', 'Norsystec', 'Couturiere', NULL),
(612, '150', 'BEN SAAD   AFIFA', 'Norsystec', 'Couturiere permanant', NULL),
(613, '152', 'AZIZI   NOURA', 'Norsystec', 'Agent de contrôle', NULL),
(614, '154', 'HAMDI   SANA', 'Norsystec', 'Agent de contrôle', NULL),
(615, '157', 'KHLIFA   DHEKRA', 'Prod. Cable WH-E', 'Agent de contrôle', NULL),
(616, '159', 'SAADLI   MONIA', 'Norsystec', 'Agent de contrôle', NULL),
(617, '160', 'BEL HADJ    EMNA', 'Norsystec', 'Agent de contrôle', NULL),
(618, '161', 'BEN HNIA    SOUMAYA', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(619, '164', 'AZIZI   SIHEM', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(620, '165', 'MESBEHI   LAMIA', 'Norsystec', 'Agent de contrôle', NULL),
(621, '171', 'EJRIDI   FOUZIA', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(622, '177', 'CHALBIA   FATMA', 'Norsystec', 'Chef d\'equipe', NULL),
(623, '179', 'BOUZAABIA   ASMA', 'Prod. Cable WH-E', 'Agent de contrôle', NULL),
(624, '180', 'BEN FRADJ   SAMIA', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(625, '187', 'KHLIFA   HANEN', 'Prod.Cable SET', 'OUVRIER(E) PERMANANT', NULL),
(626, '189', 'AZZOUZ   RADHIA', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(627, '193', 'EL HOUIJ BESSA   OUMAIMA', 'Norsystec', 'Tournante', NULL),
(628, '194', 'BEN KHLIFA   NESRIN', 'Norsystec', 'Agent de contrôle', NULL),
(629, '196', 'ROMDHAN   RIHAB', 'Norsystec', 'Agent de contrôle', NULL),
(630, '197', 'BRAHEM   SAMIRA', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(631, '198', 'BOUGEZZI   LATIFA', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(632, '199', 'AZZOUZ   SOUHIR', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(633, '201', 'BOUZAABIA    HAJER', 'Norsystec', 'AGENT DE CONTROLE TI', NULL),
(634, '204', 'ABID   MAHER', 'Logistique', 'Magasinier', NULL),
(635, '208', 'KAHLOUL   ASMA', 'Prod. Cable WH-E', 'Agent de contrôle', NULL),
(636, '209', 'CHOUIGUI   SIWAR', 'Norsystec', 'Agent de contrôle', NULL),
(637, '212', 'ZALFENI   YAMINA', 'Norsystec', 'Agent de contrôle', NULL),
(638, '215', 'ABDELLAOUI   SABRINE', 'Norsystec', 'Agent de contrôle', NULL),
(639, '218', 'DARBEL   SAHAR', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(640, '219', 'EL MANAA SLEMA   AFEF', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(641, '221', 'EL KHLIFI   THOURAIA', 'Norsystec', 'Assistante de produc', NULL),
(642, '222', 'BEN FRAJ   INES', 'Qualité', 'Agent de qualite', NULL),
(643, '223', 'HRAIECH   HAIFA', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(644, '225', 'BERRI   HAIFA', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(645, '226', 'ABID   MAROUA', 'Norsystec', 'Agent de contrôle', NULL),
(646, '227', 'BOUMAIZA   CHAIMA', 'Norsystec', 'ouvrier qualifier', NULL),
(647, '228', 'BALHADJ   BASMA', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(648, '229', 'BEN FRADJ   TAISIR', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(649, '302', 'BELHADJ   HAIFA', 'Prod.Cable SET', 'OUVRIER(E) PERMANANT', NULL),
(650, '304', 'KLII   LAMIA', 'Norsystec', 'Couturiere permanant', NULL),
(651, '307', 'EKRAM   BEN SAAD', 'Norsystec', 'Agent de contrôle', NULL),
(652, '311', 'KHLIFA   YASMINE', 'Qualité', 'Agent de qualite', NULL),
(653, '316', 'BEN ABDELGHANI   WARDA', 'Prod. Cable WH-E', 'Agent de contrôle', NULL),
(654, '323', 'HALFEOUI   IMEN', 'Norsystec', 'Agent de contrôle', NULL),
(655, '324', 'CHOUIGUI   DORSAF', 'Prod.Cable SET', 'OUVRIER(E) PERMANANT', NULL),
(656, '326', 'KHLIFI   AWATEF 2', 'Norsystec', 'Couturiere permanant', NULL),
(657, '328', 'KHLIFA   SANA', 'Prod.Cable SET', 'OUVRIER(E) PERMANANT', NULL),
(658, '330', 'HRAIECH   CHOUROUK', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(659, '333', 'TOUMIA   MAROUA', 'Norsystec', 'Agent de contrôle', NULL),
(660, '335', 'DHEKRA HRAIECH', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(661, '336', 'GRIRA   NEDIA', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(662, '338', 'EL GHAMERI   IMEN', 'Norsystec', 'Couturiere', NULL),
(663, '339', 'ELWETI   IMEN', 'Norsystec', 'OUVRIER(E)', NULL),
(664, '342', 'SOUDENI   LAZHAR', 'Ressources Huamines', 'GARDIEN Titulaire', NULL),
(665, '343', 'BOUKARMA ECHTIOUI   SIRINE', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(666, '344', 'HEDYEOUI   SAID', 'Ressources Huamines', 'GARDIEN Titulaire', NULL),
(667, '346', 'BELHADJ MILED SARRA', 'Norsystec', 'Couturiere permanant', NULL),
(668, '351', 'BILEL HAMDI', 'Norsystec', 'OUVRIER(E)', NULL),
(669, '352', 'DHOUHA JARBOUA', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(670, '353', 'DORSAF ABDEOUI', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(671, '361', 'JIHEN EL MELKI', 'Prod. Cable WH-E', 'Agent de contrôle', NULL),
(672, '362', 'SABRA AZIZI', 'Prod.Cable SET', 'OUVRIER(E) PERMANANT', NULL),
(673, '363', 'HENI AZZOUZ', 'Prod.Cable SET', 'OUVRIER(E) PERMANANT', NULL),
(674, '365', 'NAJOUA KHALFOUN', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(675, '366', 'NORHEN BEL HADJ', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(676, '368', 'HAJER KALBOUSI', 'Prod.Cable SET', 'Chef d\'equipe', NULL),
(677, '369', 'NOURHEN ABDEOUI', 'Prod.Cable SET', 'OUVRIER(E) PERMANANT', NULL),
(678, '370', 'SABER ISSAOUI', 'Logistique', 'Operateur sur machin', NULL),
(679, '371', 'MAROUA REBBEG', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(680, '374', 'FATIMA ZEMZMI', 'Prod.Cable SET', 'ouvrier qualifier', NULL),
(681, '377', 'JAMEL ZAARAOUI', 'Maintenance', 'CHEF PROD. CABLE  SE', NULL),
(682, '378', 'SIHEM SAOUDI', 'Prod. Cable WH-E', 'Couturiere', NULL),
(683, '379', 'HIBA MDALLA', 'Direction', 'Responsable Qualité', '379'),
(684, '380', 'SAIDA HAMDI', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(685, '381', 'AWATEF SLAMA', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(686, '382', 'KHAOULA KHIARI', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(687, '385', 'TAYSIR KASEM', 'Prod. Cable WH-E', 'OUVRIER(E) PERMANANT', NULL),
(688, '387', 'AFEF BRINI', 'Direction', 'Responsable AV', '387'),
(689, '388', 'FAHMI ABID', 'Logistique', 'Magasinier', NULL),
(690, '391', 'MERIEM SOUIBGUI', 'Prod.Cable SET', 'OUVRIER(E) PERMANANT', NULL),
(691, '394', 'MOUHAMED BEL HADJ', 'Logistique', 'Magasinier', NULL),
(692, '395', 'AMIRA BEN HNIA', 'Norsystec', 'OUVRIER(E)', NULL),
(693, '397', 'Fatma Hamdi', 'Norsystec', 'Couturiere permanant', NULL),
(694, '402', 'Sana Chaar', 'Norsystec', 'Agent de contrôle', NULL),
(695, '405', 'ZOUHOUR NASRI', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(696, '407', 'DALANDA KHEDHER', 'Norsystec', 'Couturiere permanant', NULL),
(697, '408', 'HAJER AMMERI', 'Norsystec', 'Agent de contrôle', NULL),
(698, '411', 'MAROUA BEN NJIMA', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(699, '412', 'SIHEM EL MHADHBI', 'Norsystec', 'Couturiere permanant', NULL),
(700, '415', 'SALMA BOUASKAR', 'Norsystec', 'Couturiere permanant', NULL),
(701, '418', 'ELHEM HOUIJ', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(702, '420', 'SIRINE BEN ABDEL GHANI', 'Norsystec', 'Couturiere', NULL),
(703, '422', 'HEDIL CHOUIGI', 'Norsystec', 'Couturiere', NULL),
(704, '424', 'SAMEH ZALFENI', 'Norsystec', 'AGENT DE CONTROLE TI', NULL),
(705, '430', 'SABRIN ZAROUKI', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(706, '433', 'CHAIMA BEN NJIMA', 'Prod.Cable SET', 'Couturiere', NULL),
(707, '437', 'HOUDA BEN HNIA', 'Norsystec', 'OUVRIER(E)', NULL),
(708, '438', 'KAWTHAR HADEJI', 'Prod. Cable WH-E', 'Tournante', NULL),
(709, '439', 'AHLEM EL ANEBI', 'Norsystec', 'OUVRIER(E)', NULL),
(710, '441', 'NESRIN HADEJI', 'Norsystec', 'OUVRIER(E)', NULL),
(711, '442', 'SAMEH ELOURIMI', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(712, '445', 'HANEN OUSIFI', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(713, '446', 'MARIEM BEN HNIA', 'Norsystec', 'Couturiere', NULL),
(714, '447', 'CHAHRAZED BELHADJ', 'Norsystec', 'OUVRIER(E)', NULL),
(715, '449', 'OUMAIMA BEMRI', 'Norsystec', 'Agent de contrôle', NULL),
(716, '450', 'ATIKA ZALFENI', 'Norsystec', 'Couturiere permanant', NULL),
(717, '453', 'RIHAB EL KHLIFI', 'Norsystec', 'Couturiere', NULL),
(718, '454', 'SALSABIL ESHILI', 'Norsystec', 'Couturiere', NULL),
(719, '457', 'ROUA HEDIEOUI', 'Norsystec', 'OUVRIER(E)', NULL),
(720, '458', 'AYMEN ELLOUETI', 'Norsystec', 'Operateur sur machin', NULL),
(721, '461', 'SAMIA BRAHEM', 'Prod.Cable SET', 'Tournante', NULL),
(722, '466', 'RANIA ESSEDIK', 'Norsystec', 'Tournante', NULL),
(723, '467', 'HNIA HAMDI', 'Norsystec', 'Couturiere', NULL),
(724, '468', 'Ferjeni Bouallegue', 'Norsystec', 'Chef Service couture', NULL),
(725, '469', 'SARRA EL BAGHDEDI', 'Norsystec', 'Couturiere permanant', NULL),
(726, '470', 'Houda Ben Njima', 'Norsystec', 'Agent de contrôle', NULL),
(727, '472', 'Yosra Nasri', 'Norsystec', 'Agent de contrôle', NULL),
(728, '474', 'INES BEN KHLIFA', 'Norsystec', 'Couturiere permanant', NULL),
(729, '475', 'HIBA HENI', 'Norsystec', 'Couturiere permanant', NULL),
(730, '479', 'WAFA ZID', 'Prod.Cable SET', 'Couturiere permanant', NULL),
(731, '482', 'WAJDI WECHTETI', 'Norsystec', 'Operateur sur machin', NULL),
(732, '485', 'CHAIMA HALFEOUI', 'Norsystec', 'OUVRIER(E) PERMANANT', NULL),
(733, '490', 'NAJEH MALLAT', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(734, '494', 'IKBEL MALLAT', 'Norsystec', 'OUVRIER(E)', NULL),
(735, '499', 'Imen Mallat', 'Norsystec', 'Couturiere permanant', NULL),
(736, '501', 'Takoua Labeoui', 'Norsystec', 'OUVRIER(E)', NULL),
(737, '502', 'Hanen Erezgui', 'Norsystec', 'Couturiere', NULL),
(738, '506', 'Romdhana Zalfeni', 'Norsystec', 'Couturiere permanant', NULL),
(739, '516', 'FEIZA CHEBBI', 'Qualité', 'Chef d\'equipe', NULL),
(740, '517', 'OUMAIMA ECHTIOUI', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(741, '518', 'SAMAR HSIN', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(742, '519', 'SAMIA MANSRI', 'Norsystec', 'Agent de contrôle', NULL),
(743, '525', 'Mounira Ammeri', 'Ressources Huamines', 'Femme de menage', NULL),
(744, '527', 'Wafa Toumia', 'Norsystec', 'OUVRIER(E)', NULL),
(745, '528', 'Asma Ezneti', 'Norsystec', 'OUVRIER(E)', NULL),
(746, '529', 'Rafika Edabbebi', 'Norsystec', 'OUVRIER(E)', NULL),
(747, '538', 'Maram Hamda', 'Norsystec', 'OUVRIER(E)', NULL),
(748, '539', 'Malek Ben Njima', 'Norsystec', 'Operateur sur machin', NULL),
(749, '544', 'Rim Barhoumi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(750, '547', 'Emna ElHendeoui', 'Prod.Cable SET', 'Couturiere', NULL),
(751, '555', 'Ibtissem Ifeoui', 'Norsystec', 'OUVRIER(E)', NULL),
(752, '558', 'Ahmed Abid', 'Prod. Cable WH-E', 'Operateur sur machin', NULL),
(753, '561', 'Imen Balghouthi', 'Norsystec', 'Agent de contrôle', NULL),
(754, '566', 'Latifa Saidi', 'Norsystec', 'Agent de contrôle', NULL),
(755, '570', 'Salwa Ben Hsin', 'Norsystec', 'OUVRIER(E)', NULL),
(756, '573', 'Sabeh Mhamdi', 'Norsystec', 'OUVRIER(E)', NULL),
(757, '576', 'Moez Bentiba', 'Direction', 'Responsable Production', '576'),
(758, '577', 'Chirine Halfeoui', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(759, '582', 'Saida Gessmi', 'Norsystec', 'Couturiere', NULL),
(760, '583', 'Naima Ismain', 'Norsystec', 'OUVRIER(E)', NULL),
(761, '584', 'Fatma Erbeihi', 'Norsystec', 'OUVRIER(E)', NULL),
(762, '594', 'Islem Daouehi', 'Norsystec', 'OUVRIER(E)', NULL),
(763, '595', 'Amal El Khlifi', 'Norsystec', 'Agent de contrôle', NULL),
(764, '597', 'Fouzia Hadeji', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(765, '605', 'Mouna Kahloul', 'Norsystec', 'Couturiere', NULL),
(766, '606', 'Souhir Grira', 'Norsystec', 'Agent de contrôle', NULL),
(767, '607', 'Yamina El Marzouki', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(768, '612', 'Nesrin Zrega Elajmi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(769, '614', 'Hanen Outai', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(770, '615', 'Souad khedher', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(771, '617', 'Rim Bouallegue', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(772, '618', 'Fathia Hamdi', 'Norsystec', 'Agent de contrôle', NULL),
(773, '619', 'chayma Khlifa', 'Qualité', 'Agent de qualite', NULL),
(774, '624', 'Fatma Hamdi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(775, '633', 'Rahma Sfaxi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(776, '637', 'Zmorda Elhadj Sghaier', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(777, '643', 'Lobna Abbes', 'Ressources Huamines', 'Femme de menage', NULL),
(778, '644', 'Thouraya Ferjeoui', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(779, '648', 'Zaineb Elhnzouli', 'Norsystec', 'OUVRIER(E)', NULL),
(780, '650', 'Fouzia Nasr', 'Norsystec', 'OUVRIER(E)', NULL),
(781, '651', 'Nejma Gizeni', 'Norsystec', 'OUVRIER(E)', NULL),
(782, '656', 'Jamila Elfakroun', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(783, '657', 'Maroua Ayedi', 'Norsystec', 'OUVRIER(E)', NULL),
(784, '659', 'Kawthar Elkrifi', 'Prod. Cable WH-E', 'Agent de contrôle', NULL),
(785, '667', 'Mouna Bouraoui', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(786, '668', 'Souhir Kahloun', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(787, '673', 'Rim Hadj Selem', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(788, '675', 'Latifa Hamdi', 'Norsystec', 'OUVRIER(E)', NULL),
(789, '684', 'Haythem Said', 'Direction', 'Responsable Unité de production', '684'),
(790, '688', 'Salwa Elsouli', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(791, '692', 'Rahma Hedyeoui', 'Norsystec', 'OUVRIER(E)', NULL),
(792, '695', 'Ahlem Bouasker', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(793, '697', 'Rami Ben Khlifa', 'Norsystec', 'OUVRIER(E)', NULL),
(794, '701', 'Atef Harrabi', 'Logistique', 'Operateur sur machin', NULL),
(795, '702', 'Hanen Gassoumi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(796, '704', 'Rihab Kahloul', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(797, '705', 'Nedia Mnasri', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(798, '712', 'Saliha Azouzi', 'Norsystec', 'OUVRIER(E)', NULL),
(799, '713', 'Najet Abbessi', 'Norsystec', 'Couturiere', NULL),
(800, '714', 'Soumaya Khlifa', 'Norsystec', 'OUVRIER(E)', NULL),
(801, '715', 'Chaima Dergech', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(802, '717', 'Chayma Bouzaienne', 'Norsystec', 'OUVRIER(E)', NULL),
(803, '718', 'Ranim El Ghoul', 'Norsystec', 'OUVRIER(E)', NULL),
(804, '720', 'Wiem Elhanzouli', 'Norsystec', 'OUVRIER(E)', NULL),
(805, '721', 'Warda Ifeoui', 'Norsystec', 'OUVRIER(E)', NULL),
(806, '725', 'Maysoun Ben Atya', 'Norsystec', 'OUVRIER(E)', NULL),
(807, '727', 'Aymen Krifi', 'Qualité', 'Technicien de qualit', NULL),
(808, '728', 'Maher Badrouch', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(809, '737', 'Radhya Mesbehi', 'Norsystec', 'Couturiere', NULL),
(810, '739', 'Ghofran Elhraiech', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(811, '746', 'Zohra Ayed', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(812, '750', 'Fatma Aouicheoui', 'Prod.Cable SET', 'EMPLOYE', NULL),
(813, '751', 'wissal Chebi', 'Norsystec', 'Agent de contrôle', NULL),
(814, '755', 'Sawssen Addeli', 'Norsystec', 'EMPLOYE', NULL),
(815, '769', 'Wissal Ben Njima', 'Norsystec', 'OUVRIER(E)', NULL),
(816, '775', 'Mouhamed Zeidi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(817, '776', 'Monjia Saadli', 'Norsystec', 'OUVRIER(E)', NULL),
(818, '780', 'Fedya Zalfeni', 'Norsystec', 'Agent de contrôle', NULL),
(819, '792', 'Wiem Zalfeni', 'Norsystec', 'Agent de contrôle', NULL),
(820, '795', 'Rabiaa Thleijia', 'Norsystec', 'OUVRIER(E)', NULL),
(821, '797', 'Amira Amara', 'Norsystec', 'OUVRIER(E)', NULL),
(822, '809', 'Soukaina Tiehi', 'Norsystec', 'OUVRIER(E)', NULL),
(823, '810', 'Amal Mighri', 'Norsystec', 'OUVRIER(E)', NULL),
(824, '811', 'Med Amin Ben Abdelghani', 'Norsystec', 'OUVRIER(E)', NULL),
(825, '812', 'Atef Addeli', 'Norsystec', 'OUVRIER(E)', NULL),
(826, '814', 'Rebeh Elghnoudi', 'Norsystec', 'OUVRIER(E)', NULL),
(827, '819', 'Awatef Barhoumi', 'Norsystec', 'OUVRIER(E)', NULL),
(828, '821', 'Rahma Taamallah', 'Norsystec', 'Agent de contrôle', NULL),
(829, '829', 'Chayma Abdelghani', 'Norsystec', 'Couturiere', NULL),
(830, '830', 'Israa Essessi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(831, '833', 'Hajer Mtiraoui', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(832, '839', 'Rahma Elayari', 'Norsystec', 'Agent de contrôle', NULL),
(833, '842', 'Omar Karmous', 'Norsystec', 'OUVRIER(E)', NULL),
(834, '849', 'Jihen Chmangui', 'Norsystec', 'OUVRIER(E)', NULL),
(835, '850', 'Amira Barhoumi', 'Norsystec', 'OUVRIER(E)', NULL),
(836, '851', 'Amal Farhani', 'Norsystec', 'OUVRIER(E)', NULL),
(837, '853', 'Afef Elkhlifi', 'Norsystec', 'OUVRIER(E)', NULL),
(838, '854', 'Samia Harrabi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(839, '860', 'Achraf Gessem', 'Logistique', 'Magasinier', NULL),
(840, '861', 'Nawres Isseoui', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(841, '866', 'Imen Abdellaoui', 'Norsystec', 'OUVRIER(E)', NULL),
(842, '871', 'Abdelmonem Zaidi', 'Prod. Cable WH-E', 'Operateur sur machin', NULL),
(843, '873', 'Saida Taam', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(844, '879', 'Ala Abdeoui', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(845, '883', 'Molka Hlel', 'Norsystec', 'OUVRIER(E)', NULL),
(846, '884', 'Amina Essid', 'Norsystec', 'Couturiere', NULL),
(847, '885', 'Sami Najleoui', 'Maintenance', 'Tech maintenance-Pro', NULL),
(848, '886', 'Amira Enajleoui', 'Norsystec', 'OUVRIER(E)', NULL),
(849, '888', 'Omar Edawdi', 'Norsystec', 'OUVRIER(E)', NULL),
(850, '889', 'Asma Ezaliiti', 'Norsystec', 'OUVRIER(E)', NULL),
(851, '890', 'Mouhamed Aziz Ameri', 'Logistique', 'Magasinier', NULL),
(852, '891', 'Aida Enajleoui', 'Norsystec', 'OUVRIER(E)', NULL),
(853, '892', 'Imed Zeidi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(854, '893', 'Rihab Bougezzi', 'Prod.Cable SET', 'Operateur sur machin', NULL),
(855, '894', 'Maroua Mesbehi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(856, '903', 'Soumaya Kechich', 'Prod.Cable SET', 'Agent de contrôle', NULL),
(857, '905', 'Samia Sbaii', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(858, '912', 'Rafika Balghouthi', 'Norsystec', 'Couturiere', NULL),
(859, '915', 'Najoua Elousifi', 'Norsystec', 'Couturiere', NULL),
(860, '920', 'Hayfa Boujlida', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(861, '922', 'Zahra Aiechi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(862, '923', 'Rim Agoubi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(863, '926', 'Nahed Haddeji', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(864, '929', 'Intissar Fdhily', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(865, '931', 'Aya Khlifa', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(866, '933', 'Amir Elhaouem', 'Logistique', 'Magasinier', NULL),
(867, '935', 'Bouthayna Ben hnia', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(868, '938', 'Ichrak Elhattab', 'Norsystec', 'OUVRIER(E)', NULL),
(869, '939', 'Aya Omezzin Bel hadj', 'Norsystec', 'OUVRIER(E)', NULL),
(870, '945', 'Houda Hanzouli', 'Norsystec', 'Couturiere', NULL),
(871, '948', 'Narjes Ayedi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(872, '950', 'Mariem Elkemti', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(873, '952', 'Amal Ifeoui', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(874, '954', 'Mahmoud Azzouz', 'Logistique', 'Magasinier', NULL),
(875, '958', 'Afef Debech', 'Norsystec', 'OUVRIER(E)', NULL),
(876, '959', 'Jamila Ben Hsan', 'Norsystec', 'OUVRIER(E)', NULL),
(877, '961', 'Sawssen Ben Hadj Mahmoud', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(878, '964', 'Zaineb Tayen', 'Norsystec', 'Agent de contrôle', NULL),
(879, '966', 'Khouloud bouaskar', 'Norsystec', 'Couturiere', NULL),
(880, '968', 'Manel Elouergmi', 'Norsystec', 'OUVRIER(E)', NULL),
(881, '969', 'Senda Bouaskar', 'Norsystec', 'OUVRIER(E)', NULL),
(882, '971', 'Gazi Baklouti', 'Norsystec', 'OUVRIER(E)', NULL),
(883, '972', 'Henda Elhanzouli', 'Norsystec', 'Couturiere', NULL),
(884, '975', 'Samah Dioueni', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(885, '978', 'Abir Elothmani', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(886, '980', 'Aiada Abdellaoui', 'Norsystec', 'Couturiere', NULL),
(887, '982', 'Ikram Mesbehi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(888, '984', 'Med Ali Hraiech', 'Norsystec', 'Operateur sur machin', NULL),
(889, '985', 'Racha Selimi', 'Norsystec', 'OUVRIER(E)', NULL),
(890, '988', 'Molka Ben Ahmed', 'Norsystec', 'OUVRIER(E)', NULL),
(891, '990', 'Yosra Nasri', 'Norsystec', 'OUVRIER(E)', NULL),
(892, '995', 'Helmi Bouzaabia', 'Norsystec', 'OUVRIER(E)', NULL),
(893, '996', 'Monia Zneki', 'Norsystec', 'OUVRIER(E)', NULL),
(894, '999', 'Majda Dhifellaoui', 'Norsystec', 'OUVRIER(E)', NULL),
(895, '1001', 'Radhia Ftiti', 'Norsystec', 'OUVRIER(E)', NULL),
(896, '1006', 'Sawssen Zaibi', 'Norsystec', 'OUVRIER(E)', NULL),
(897, '1011', 'Sahar Elsaadli', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(898, '1015', 'Nermin Karmous', 'Norsystec', 'OUVRIER(E)', NULL),
(899, '1018', 'Chiraz Elothmani', 'Norsystec', 'OUVRIER(E)', NULL),
(900, '1025', 'Mouna Zaidi', 'Norsystec', 'OUVRIER(E)', NULL),
(901, '1048', 'Sana Marzouki', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(902, '1049', 'Rakia Mbark', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(903, '1055', 'Samar Abdelghani', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(904, '1063', 'Amal Amaira', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(905, '1068', 'Amal Hamdi', 'Norsystec', 'OUVRIER(E)', NULL),
(906, '1075', 'Yosr Bouzaabia', 'Norsystec', 'OUVRIER(E)', NULL),
(907, '1077', 'Faten Ali', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(908, '1083', 'ADEM BEN HMIDA', 'Logistique', 'Operateur sur machin', NULL),
(909, '1089', 'Samia Ksouda', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(910, '1091', 'Salma Mabrouki', 'Norsystec', 'OUVRIER(E)', NULL),
(911, '1093', 'Elhem Abdellaoui', 'Norsystec', 'OUVRIER(E)', NULL),
(912, '1095', 'Jamila Dhaouedi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(913, '1111', 'Sana Souii', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(914, '1119', 'Hayet BEN SAAD', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(915, '1120', 'Hanin Labidi', 'Norsystec', 'OUVRIER(E)', NULL),
(916, '1122', 'MAROUA MNED', 'Norsystec', 'OUVRIER(E)', NULL),
(917, '1124', 'AMMAR HNAZLI', 'Norsystec', 'OUVRIER(E)', NULL),
(918, '1125', 'YASSINE KHLIFA', 'Norsystec', 'OUVRIER(E)', NULL),
(919, '1131', 'Ahlem Bannouri', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(920, '1133', 'Seifeddine Kmilete', 'Direction', 'Responsable RH', '1133'),
(921, '1139', 'Asma Hbari', 'Norsystec', 'OUVRIER(E)', NULL),
(922, '1141', 'Iselm Khobzi', 'Norsystec', 'OUVRIER(E)', NULL),
(923, '1143', 'Sawssen Bouzaabia', 'Norsystec', 'OUVRIER(E)', NULL),
(924, '1152', 'Houssemddine Bouasker', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(925, '1157', 'Omezzine Ben Hmida', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(926, '1158', 'Donia Karoui', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(927, '1161', 'Omar Ben Chaabane', 'Norsystec', 'OUVRIER(E)', NULL),
(928, '1165', 'Sameh Bouzaabia', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(929, '1166', 'Jihene Bouzaabia', 'Norsystec', 'OUVRIER(E)', NULL),
(930, '1167', 'Ons Ghribi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(931, '1168', 'Imen Ben Hafsia', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(932, '1171', 'Wafa Horchani', 'Norsystec', 'OUVRIER(E)', NULL),
(933, '1173', 'Fattoum Yaacoubi', 'Norsystec', 'OUVRIER(E)', NULL),
(934, '1175', 'Amel Chebli', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(935, '1176', 'Mohamed Sayari', 'Maintenance', 'TECH sup maintenance', NULL),
(936, '1184', 'Jawaher Frioui', 'Norsystec', 'OUVRIER(E)', NULL),
(937, '1185', 'Mohamed Aziz Khlifa', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(938, '1188', 'Hanadi Bouzaabia', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(939, '1189', 'Rihab Yaacoubi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(940, '1190', 'Thouraya Henchiri', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(941, '1192', 'Latifa Abdelghani', 'Norsystec', 'Couturiere', NULL),
(942, '1193', 'Intissar Bouguezzi', 'Norsystec', 'OUVRIER(E)', NULL),
(943, '1194', 'Hanen Abaidi', 'Norsystec', 'Couturiere', NULL),
(944, '1195', 'Nassima Abdaoui', 'Norsystec', 'OUVRIER(E)', NULL),
(945, '1196', 'chaima Abdaoui', 'Norsystec', 'OUVRIER(E)', NULL),
(946, '1197', 'Fatma Mnissi', 'Norsystec', 'OUVRIER(E)', NULL),
(947, '1202', 'Salma Khlifi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(948, '1206', 'Chaima Aini', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(949, '1207', 'Arwa Zitouni', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(950, '1208', 'Faiza Khlifi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(951, '1210', 'Marwa Ayed', 'Norsystec', 'OUVRIER(E)', NULL),
(952, '1211', 'Souad Khlifi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(953, '1213', 'Wissem Ghazouani', 'Ressources Huamines', 'Chauffeur', NULL),
(954, '1224', 'Imen Bouraoui', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(955, '1229', 'Amal Bouzaabia', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(956, '1231', 'Kawther Jaballah', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(957, '1232', 'Mariem Baccouche', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(958, '1233', 'Amani Fteiti', 'Norsystec', 'OUVRIER(E)', NULL),
(959, '1236', 'Dhekra Khlifa', 'Norsystec', 'OUVRIER(E)', NULL),
(960, '1241', 'Mariem Bouzaabia', 'Norsystec', 'OUVRIER(E)', NULL),
(961, '1243', 'Rihab Baccouche', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(962, '1246', 'Takwa Zalfani', 'Norsystec', 'OUVRIER(E)', NULL),
(963, '1247', 'Mariem Ben Njima', 'Norsystec', 'OUVRIER(E)', NULL),
(964, '1255', 'Fatma Saoudi', 'Norsystec', 'EMPLOYE', NULL),
(965, '1256', 'Nahida Kassebi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(966, '1258', 'Seifeddine Abbadi', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(967, '1261', 'Souha Fhima', 'Logistique', 'Agent Logistique', NULL),
(968, '1262', 'Mayssa Ben Ali', 'Logistique', 'Agent Logistique', NULL),
(969, '1264', 'Anwar Ben Aicha', 'Direction', 'ASSISTANTE DE DIRECT', NULL),
(970, '1265', 'Sami Ben Saad', 'Prod.Cable SET', 'Operateur sur machin', NULL),
(971, '1267', 'Oussama Khlifi', 'Prod.Cable SET', 'Operateur sur machin', NULL),
(972, '1269', 'Wiem Jouini', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(973, '1271', 'Mariem Ben Hassen', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(974, '1272', 'Samar Toumi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(975, '1273', 'Ines Yahyaoui', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(976, '1274', 'Sana Rebhi', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(977, '1275', 'Chaima Guesem', 'Norsystec', 'OUVRIER(E)', NULL),
(978, '1276', 'Sirine Ben Romdhane', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(979, '1278', 'Haifa Bouraoui', 'Norsystec', 'OUVRIER(E)', NULL),
(980, '1280', 'Seifeddine Salem', 'Norsystec', 'OUVRIER(E)', NULL),
(981, '1281', 'Mohamed Houcine Azzouz', 'Norsystec', 'OUVRIER(E)', NULL),
(982, '1282', 'Chaima Hassini', 'Norsystec', 'Couturiere', NULL),
(983, '1283', 'Jihen Bouasker', 'Norsystec', 'OUVRIER(E)', NULL),
(984, '1284', 'Lina Hamdi', 'Norsystec', 'OUVRIER(E)', NULL),
(985, '1286', 'Maroua Chaabani', 'Norsystec', 'OUVRIER(E)', NULL),
(986, '1290', 'Tayma Khlifa', 'Norsystec', 'OUVRIER(E)', NULL),
(987, '1292', 'Amal Houas', 'Prod. Cable WH-E', 'OUVRIER(E)', NULL),
(988, '1293', 'Nadhem Hedyaoui', 'Prod.Cable SET', 'OUVRIER(E)', NULL),
(989, '1295', 'Mohamed Mahmoud', 'Norsystec', 'OUVRIER(E)', NULL),
(990, '1298', 'Mohamed Arif', 'Norsystec', 'OUVRIER(E)', NULL),
(991, '1299', 'Fethi Hnazli', 'Norsystec', 'Operateur sur machin', NULL),
(992, '1300', 'Mohaned Ben Njima', 'Norsystec', 'Operateur sur machin', NULL),
(993, '1301', 'Nabil  Sayhi', 'Norsystec', 'OUVRIER(E)', NULL),
(994, '1302', 'Zohra Jaouadi', 'Ressources Huamines', 'Femme de menage', NULL),
(995, '1303', 'Raja Jeddi', 'Norsystec', 'OUVRIER(E)', NULL),
(996, '1305', 'Syrine Bouattay', 'Méthode', 'Ingenieur Methode', NULL),
(997, '1306', 'Chaima Allagui', 'Méthode', 'Ingenieur Methode', NULL),
(998, '1309', 'Mariem Khabbacha', 'Qualité', 'Agent de qualite', NULL),
(999, '1315', 'Ali Sghaier', 'Norsystec', 'OUVRIER(E)', NULL),
(1000, '1320', 'Ibtissem TLILI', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1001, '1322', 'Ramzi Kheder', 'Prod.Cable SET', 'EMPLOYE', NULL),
(1002, '1323', 'Samia Ezzi', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1003, '1324', 'Amal Hamdi', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1004, '1325', 'Henda Belgacem', 'Prod.Cable SET', 'EMPLOYE', NULL),
(1005, '1327', 'Bouthaina Hamdi', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1006, '1328', 'Rabiaa Khlifi', 'Norsystec', 'EMPLOYE', NULL),
(1007, '1373', 'Khalil Belghouthi', 'Logistique', 'EMPLOYE', NULL),
(1008, '1376', 'Houssemddine Lakhal', 'Direction', 'Spécialiste import/export', '1376'),
(1009, '1377', 'Mohamed Bouraoui Trabelsi', 'Maintenance', 'EMPLOYE', NULL),
(1010, '1378', 'Makrem Selmi', 'Maintenance', 'EMPLOYE', NULL),
(1011, '1380', 'Rania Romdhane', 'Logistique', 'EMPLOYE', NULL),
(1012, '1382', 'Samah Haj Ali', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1013, '1383', 'Hanen Raisi', 'Prod.Cable SET', 'EMPLOYE', NULL),
(1014, '1384', 'Monia Abboud', 'Prod.Cable SET', 'EMPLOYE', NULL),
(1015, '1387', 'Kaisser Bouassida', 'Méthode', 'EMPLOYE', NULL),
(1016, '1388', 'Sami Sagaama', 'Méthode', 'EMPLOYE', NULL),
(1017, '1389', 'Marwa Bouzaabia', 'Prod.Cable SET', 'EMPLOYE', NULL),
(1018, '1390', 'Yosra Loussifi', 'Prod.Cable SET', 'EMPLOYE', NULL),
(1019, '1391', 'Ameni Amri', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1020, '1392', 'Radhia Ammar', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1021, '1393', 'Afef Aouichi', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1022, '1394', 'Hayet Chorfa', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1023, '1395', 'Hasna Bouyahya', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1024, '1396', 'Ridha Allouche', 'Ressources Huamines', 'GARDIEN', '1396'),
(1025, '1399', 'Wissemeddine KHAYATI', 'Logistique', 'EMPLOYE', NULL),
(1026, '1401', 'Sana Mhadhbi', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1027, '1402', 'Chaima Abdelghani', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1028, '1403', 'Maram Rached', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1029, '1405', 'Amina Bouraoui', 'Prod. Cable WH-E', 'EMPLOYE', NULL),
(1030, '1406', 'Yassine Znagui', 'Ressources Huamines', 'EMPLOYE', NULL),
(1031, '1408', 'Rabiaa Hamdi', 'Prod.Cable SET', 'EMPLOYE', NULL),
(1032, '1409', 'Khaled Achour', 'Qualité', 'EMPLOYE', NULL),
(1033, '1410', 'Karem Mahmoudi', 'Prod.Cable SET', 'EMPLOYE', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `historique_anomalie`
--

CREATE TABLE `historique_anomalie` (
  `id` bigint(20) NOT NULL,
  `commentaire` varchar(255) DEFAULT NULL,
  `date_validation` datetime(6) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `valide_par` varchar(255) DEFAULT NULL,
  `anomalie_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `historique_anomalie_seq`
--

CREATE TABLE `historique_anomalie_seq` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `historique_anomalie_seq`
--

INSERT INTO `historique_anomalie_seq` (`next_val`) VALUES
(1);

-- --------------------------------------------------------

--
-- Structure de la table `infermerie`
--

CREATE TABLE `infermerie` (
  `id` bigint(20) NOT NULL,
  `date` date DEFAULT NULL,
  `motif` varchar(255) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `infermerie`
--

INSERT INTO `infermerie` (`id`, `date`, `motif`, `statut`, `type`, `employe_id`) VALUES
(1, '2025-08-04', '', 'Acceptée', 'Consultation', 448),
(2, '2025-08-04', 'jknhdzg', 'Refusée', 'Autre', 554);

-- --------------------------------------------------------

--
-- Structure de la table `interrogatoire`
--

CREATE TABLE `interrogatoire` (
  `id` bigint(20) NOT NULL,
  `date` date DEFAULT NULL,
  `date_conseil_discipline` date DEFAULT NULL,
  `date_debut_suspension` date DEFAULT NULL,
  `duree_suspension` int(11) DEFAULT NULL,
  `punition_proposee` varchar(255) DEFAULT NULL,
  `reponse` text DEFAULT NULL,
  `sujet` varchar(255) DEFAULT NULL,
  `employe_id` bigint(20) DEFAULT NULL,
  `nombre_jours` int(11) DEFAULT NULL,
  `reponse_employe` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `interrogatoire`
--

INSERT INTO `interrogatoire` (`id`, `date`, `date_conseil_discipline`, `date_debut_suspension`, `duree_suspension`, `punition_proposee`, `reponse`, `sujet`, `employe_id`, `nombre_jours`, `reponse_employe`) VALUES
(1, '2025-08-01', NULL, NULL, NULL, 'Suspension temporaire du travail', NULL, 'RETRGTZEGRHT', 448, 2, 'gyuftdrx'),
(3, '2025-07-31', NULL, NULL, NULL, 'Avertissement verbal', NULL, 'SDEFRGT', 554, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `paie`
--

CREATE TABLE `paie` (
  `id` bigint(20) NOT NULL,
  `date_paie` date DEFAULT NULL,
  `mois` varchar(255) DEFAULT NULL,
  `montant` double NOT NULL,
  `employe_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `anomalie_paie`
--
ALTER TABLE `anomalie_paie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKbglujf7qbduuo2rvvcbl8muic` (`employe_id`);

--
-- Index pour la table `anomalie_pointage`
--
ALTER TABLE `anomalie_pointage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK12d69be0visqmdwqkkn0ofwjl` (`employe_id`);

--
-- Index pour la table `autorisation`
--
ALTER TABLE `autorisation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKjim3049anb7j1xu8b2xidtt8k` (`employe_id`);

--
-- Index pour la table `avance_salaire`
--
ALTER TABLE `avance_salaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKaxd2m055u90ibyokeabca3df5` (`employe_id`);

--
-- Index pour la table `conge`
--
ALTER TABLE `conge`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKlqg9rybgeokq9ibtk7ymycjeq` (`employe_id`);

--
-- Index pour la table `demande_document`
--
ALTER TABLE `demande_document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKk7en0m3h6v29mfrumq4in9935` (`employe_id`);

--
-- Index pour la table `emission`
--
ALTER TABLE `emission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK77tfsv532c30rhdoatyk1cyqv` (`employe_id`);

--
-- Index pour la table `employe`
--
ALTER TABLE `employe`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `historique_anomalie`
--
ALTER TABLE `historique_anomalie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK124m5ef5ymg5ljrmmjvolm4tc` (`anomalie_id`);

--
-- Index pour la table `infermerie`
--
ALTER TABLE `infermerie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKfmmbcqhp6yne4uhf8t36qt8sc` (`employe_id`);

--
-- Index pour la table `interrogatoire`
--
ALTER TABLE `interrogatoire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK51m3g3rgtu2bwjy2obdun2ls2` (`employe_id`);

--
-- Index pour la table `paie`
--
ALTER TABLE `paie`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKachhu6y621mgs6vi2v9my0717` (`employe_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `anomalie_paie`
--
ALTER TABLE `anomalie_paie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `autorisation`
--
ALTER TABLE `autorisation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT pour la table `conge`
--
ALTER TABLE `conge`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `demande_document`
--
ALTER TABLE `demande_document`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `emission`
--
ALTER TABLE `emission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `employe`
--
ALTER TABLE `employe`
  MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=555;

--
-- AUTO_INCREMENT pour la table `infermerie`
--
ALTER TABLE `infermerie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `interrogatoire`
--
ALTER TABLE `interrogatoire`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `paie`
--
ALTER TABLE `paie`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `anomalie_paie`
--
ALTER TABLE `anomalie_paie`
  ADD CONSTRAINT `FKbglujf7qbduuo2rvvcbl8muic` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `anomalie_pointage`
--
ALTER TABLE `anomalie_pointage`
  ADD CONSTRAINT `FK12d69be0visqmdwqkkn0ofwjl` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `autorisation`
--
ALTER TABLE `autorisation`
  ADD CONSTRAINT `FKjim3049anb7j1xu8b2xidtt8k` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `avance_salaire`
--
ALTER TABLE `avance_salaire`
  ADD CONSTRAINT `FKaxd2m055u90ibyokeabca3df5` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `conge`
--
ALTER TABLE `conge`
  ADD CONSTRAINT `FKlqg9rybgeokq9ibtk7ymycjeq` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `demande_document`
--
ALTER TABLE `demande_document`
  ADD CONSTRAINT `FKk7en0m3h6v29mfrumq4in9935` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `emission`
--
ALTER TABLE `emission`
  ADD CONSTRAINT `FK77tfsv532c30rhdoatyk1cyqv` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `historique_anomalie`
--
ALTER TABLE `historique_anomalie`
  ADD CONSTRAINT `FK124m5ef5ymg5ljrmmjvolm4tc` FOREIGN KEY (`anomalie_id`) REFERENCES `anomalie_pointage` (`id`);

--
-- Contraintes pour la table `infermerie`
--
ALTER TABLE `infermerie`
  ADD CONSTRAINT `FKfmmbcqhp6yne4uhf8t36qt8sc` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `interrogatoire`
--
ALTER TABLE `interrogatoire`
  ADD CONSTRAINT `FK51m3g3rgtu2bwjy2obdun2ls2` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `paie`
--
ALTER TABLE `paie`
  ADD CONSTRAINT `FKachhu6y621mgs6vi2v9my0717` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
